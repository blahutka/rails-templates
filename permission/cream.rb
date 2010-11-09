add_source 'http://gems.github.com'

#gem 'cream',  '~> 0.5.5'
gem 'devise'
gem 'cancan'
#gem 'roles_mongoid' # http://github.com/kristianmandrup/roles_generic


stategies << lambda do
  generate 'devise:install'
  generate 'devise:views'
  generate 'devise User'

 
  puts "adding a 'name' attribute to the User model"
  gsub_file 'app/models/user.rb', /end/ do
    <<-RUBY
  field :first_name
  field :last_name
  field :roles_mask, :type => Integer

  validates_uniqueness_of :email, :case_sensitive => false
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :remember_me

  
  ROLES = %w[admin moderator guest accountant]

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end

  def role?(role)
    roles.include? role.to_s
  end
end
    RUBY
  end

  file 'app/models/ability.rb' do
    <<-TXT
      class Ability
        include CanCan::Ability

        def initialize(user)
          can :manage, :all if user.role? :admin
          can :assign_roles, User if user.role? :admin
        end
      end
    TXT
  end

  gsub_file 'config/environments/development.rb', /config.action_mailer.raise_delivery_errors = false/ do
    <<-RUBY
config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  # A dummy setup for development - no deliveries, but logged
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = false
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default :charset => "utf-8"
    RUBY
  end

  gsub_file 'config/environments/production.rb', /config.i18n.fallbacks = true/ do
    <<-RUBY
config.i18n.fallbacks = true

  config.action_mailer.default_url_options = { :host => 'yourhost.com' }
  ### ActionMailer Config
  # Setup for production - deliveries, no errors raised
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default :charset => "utf-8"
    RUBY
  end

  puts "creating a default user"
  append_file 'db/seeds.rb' do <<-FILE
    puts 'EMPTY THE MONGODB DATABASE'
    Mongoid.master.collections.reject { |c| c.name == 'system.indexes'}.each(&:drop)
    puts 'SETTING UP DEFAULT USER LOGIN'
    user = User.create! :first_name => 'petr', :last_name => 'petr', :email => 'petr@test.com', :password => 'password', :password_confirmation => 'password'
    user.roles = ['admin', 'guest']
    user.save
    puts 'New user created: ' << user.email
    FILE
  end
  rake 'db:seed'

  inject_into_file 'app/controllers/application_controller.rb', :after => '::Base' do
    <<-TXT
    
    before_filter :authenticate_user!

    rescue_from CanCan::AccessDenied do |exception|
      flash[:error] = exception.message
      redirect_to root_url
    end
    TXT
  end

  generate 'controller Home index'
  generate 'controller User index'

  gsub_file 'app/controllers/home_controller.rb', /def index/ do
    <<-TXT
      load_and_authorize_resource
      def index
        @user = User.all
    TXT
  end

  append_file 'app/views/home/index.html.erb' do
    <<-TXT
      <%= link_to 'Logout', logout_path %>
      <% if can? :assign_roles, @user %>
       <p>Hello, you are an Admin</p>
       <h2>Users</h2>
       <% for user in @user %>
         <p><%= user.email %> <%= link_to "Edit User", edit_user_path(user) %> <%= link_to "Delete User", user, :confirm => "Are you sure?", :method => :delete %>
       <% end %>
      <% else %>
       <p>Hello, you are not an Admin</p>
     <% end %>
    TXT
  end

  route 'get "home/index" '
  route "root :to => 'home#index' "
  route "devise_for :users"
  route <<-TXT
    devise_scope :user do
      get '/login' => 'devise/sessions#new'
      get '/logout' => 'devise/sessions#destroy'
    end
  TXT
  route 'resources :user'

end