# info
# http://apidock.com/rails/Rails/TemplateRunner/file
# http://m.onkey.org/2008/12/4/rails-templates
# http://github.com/drnic/rails-templates
# http://rdoc.info/github/wycats/thor/master/Thor/Actions
# http://github.com/fortuity/rails3-mongoid-devise/blob/master/template.rb
# http://rdoc.info/github/rails/rails/master/Rails/Generators/Actions

# FILE
gsub_file 'config/deploy.rb', /set :deploy_via, :copy/, "set :deploy_via, :copy\nset :copy_compression, :zip"
gsub_file("app/controllers/application_controller.rb", /class ApplicationController < ActionController::Base/mi) do
  <<-EOS.gsub(/^ /, '')
    class ApplicationController < ActionController::Base
    before_filter :authenticate_user!
  EOS
end

get "http://code.jquery.com/jquery-latest.min.js", "public/javascripts/jquery.js"
file '.gitignore', <<-END
 # add content
END

file 'lib/tasks/cron.rake', <<-EOS.gsub(/^ /, '')
desc "Entry point for cron tasks"
task :cron do

end
EOS

file("lib/fun_party.rb") do
  hostname = ask("What is the virtual hostname I should use?")
  "vhost.name = #{hostname}"
end

append_file 'config/environments/development.rb', <<-EOS.gsub(/^ /, '')
config.action_mailer.default_url_options = { :host => '.local' }
EOS
inject_into_file "app/views/devise/registrations/edit.html.erb", :after => "<%= devise_error_messages! %>\n" do
  <<-TXT
  content
TXT
end
# PLUGIN
plugin 'rspec', :git => 'git://github.com/dchelimsky/rspec.git', :submodule => true

# COMMANDS
run "ln -sf ~/workspace/rubber vendor/plugins"
inside('vendor') { run 'ln -s ~/dev/rails/rails rails' }

# GENERATORS
generate(:scaffold, "post", "title:string", "body:text")

# CONDITIONS
templates = ask("Which rubber templates [complete_passenger_mysql] ?")
if yes?('Ask something?')
  #do
end

# RAKE
rake('gems:install', :sudo => true, :env => 'test')
rake('db:sessions:create')

# GIT
git :init
git :add => '.'

# LOG
log(:info, 'Installing gems')
