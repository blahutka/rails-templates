gem 'mongoid', '2.0.0.beta.19'
gem 'bson_ext'

run 'bundle install'
generate 'mongoid:config'
gsub_file 'config/application.rb', /^\s*.require 'rails\/all'/ do
  <<-TXT
  #require 'rails/all'
   require "action_controller/railtie"
   require "action_mailer/railtie"
   require "active_resource/railtie"
  TXT
end