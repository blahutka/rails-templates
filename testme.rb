gem 'cucumber-rails'
inside app_name do
  run 'bundle install'
end

stategies <<  lambda do
  generate 'cucumber:install --rspec --capybara --skip-database'
end
