gem 'devise' # Devise must be required before RailsAdmin
gem 'rails_admin', :git => 'git://github.com/sferik/rails_admin.git'

run 'bundle install'
generate 'rails_admin:install_admin'