# Delete unnecessary files
run "rm README"
run "rm public/index.html"
run "rm public/favicon.ico"
run "rm public/images/rails.png"

# From http://github.com/lleger/Rails-3-jQuery
if yes?('Use jQuery?')
  inside('public/javascripts') do
    FileUtils.rm_rf %w(controls.js dragdrop.js effects.js prototype.js rails.js)
  end

  get "http://code.jquery.com/jquery-latest.min.js", "public/javascripts/jquery.js"
  get "http://github.com/rails/jquery-ujs/raw/master/src/rails.js", "public/javascripts/rails.js"
  initializer 'jquery.rb', <<-CODE
    ActionView::Helpers::AssetTagHelper.register_javascript_expansion :jquery => ['jquery', 'rails']
    ActiveSupport.on_load(:action_view) do
    ActiveSupport.on_load(:after_initialize) do
      ActionView::Helpers::AssetTagHelper::register_javascript_expansion :defaults => ['jquery', 'rails']
      end
    end
  CODE
end

gem 'acts_as_tree'
gem "simple_form"
gem 'inherited_resources', '1.1.2'
gem 'has_scope'
gem 'compass', :group => :development

# GIT
file '.gitignore', <<-END
.DS_Store
log/*.log
tmp/**/*
config/database.yml
db/*.sqlite3
vendor/rails
END

git :init
git :add => '.'

if yes?('Add gem rails_admin?')
  gem 'devise' # Devise must be required before RailsAdmin
  gem 'rails_admin', :git => 'git://github.com/sferik/rails_admin.git'
  generate 'rails_admin:install_admin'
end

#gem 'test-unit', :group => [:development, :test]

if yes?('Add Rspec setting')
  gem "rspec", :group => [:development, :test]
  #gem "rspec-rails", ">= 2.0.0.beta", :group => [:development, :test]
  gem "machinist", :git => "git://github.com/notahat/machinist.git", :group => [:development, :test]
  gem "faker",:group => [:development, :test]
  gem "ZenTest", :group => [:development, :test]
  gem "autotest", :group => [:development, :test]
  gem "autotest-rails", :group => [:development, :test]
  gem "cucumber-rails", :git => "git://github.com/aslakhellesoy/cucumber-rails.git", :group => [:development, :test]
  gem "cucumber", :git => "git://github.com/aslakhellesoy/cucumber.git", :group => [:development, :test]
  gem "database_cleaner", :git => 'git://github.com/bmabey/database_cleaner.git', :group => [:development, :test]  
  #gem "capybara", :group => [:development, :test]
  gem "capybara-envjs",:group => [:development, :test]
  gem "launchy", :group => [:development, :test]
  gem "ruby-debug", :group => [:development, :test]

  log(:info, 'Installing gems')
  run 'bundle install'
  run 'bundle update' #resolv gem colisions
  run 'rvm reload'
  generate('rspec:install')
  generate('cucumber:install', '--capybara --rspec')
end


if yes?('Run DB create?')
  rake 'db:create'
  rake 'db:migrate'
end

if yes?('Test cucumber?')
  rake 'cucumber'
end

if yes?('Do you want generate something?')
  first = ask("eg. scaffold Product name:string category:references, description:text parent_id:integer")
  generate(:model, first)
end

