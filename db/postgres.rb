gem 'pg'

run 'bundle install'

gsub_file 'config/application.rb', /#require 'rails\/all'/ do
  <<-TXT
require 'rails/all'
TXT
end