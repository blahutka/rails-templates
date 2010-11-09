log :info, 'MongoDb'
log :info, 'mongo should run on: http://localhost:28017'
log :info, 'or in console type: mongo'

gem 'mongoid', '2.0.0.beta.19'
gem 'bson_ext'

stategies << lambda do
  generate 'mongoid:config'

  log :info, 'Disabeling: require "rails/all -> config/application.rb"'
  gsub_file 'config/application.rb', /^\s.*require 'rails\/all'/ do
    <<-TXT
#require 'rails/all'
require "action_controller/railtie" #for mongodb
require "action_mailer/railtie"     #for mongodb
require "active_resource/railtie"   #for mongodb
    TXT
  end

end