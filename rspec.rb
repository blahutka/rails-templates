gem 'acts_as_tree'
gem "simple_form"
gem 'inherited_resources', '1.1.2'
gem 'has_scope'
gem 'compass', :group => :development
gem 'devise'

if yes?('Add gem rails_admin?')
  gem 'rails_admin', :git => 'git://github.com/sferik/rails_admin.git'
end
gem 'test-unit', :group => [:development, :test]

if yes?('Add Rspec setting')
  gem "rspec", :group => [:development, :test]
  gem "rspec-rails", ">= 2.0.0.beta", :group => [:development, :test]
  gem "machinist", :git => "git://github.com/notahat/machinist.git", :group => [:development, :test]
  gem "faker",:group => [:development, :test]
  gem "ZenTest", :group => [:development, :test]
  gem "autotest", :group => [:development, :test]
  gem "autotest-rails", :group => [:development, :test]
  gem "cucumber",         :git => "git://github.com/aslakhellesoy/cucumber.git", :group => [:development, :test]
  gem "database_cleaner", :git => 'git://github.com/bmabey/database_cleaner.git', :group => [:development, :test]
  gem "cucumber-rails",   :git => "git://github.com/aslakhellesoy/cucumber-rails.git", :group => [:development, :test]
  gem "capybara",:group => [:development, :test]
  gem "capybara-envjs",:group => [:development, :test]
  gem "launchy", :group => [:development, :test]
  gem "ruby-debug", :group => [:development, :test]

  log(:info, 'Installing gems')
  run 'bundle install'
  generate('rspec:install')
  generate('cucumber:skeleton', '--capybara --rspec')
end

run 'bundle install'
