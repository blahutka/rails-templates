log :info, 'Setup rspec with cucumber'
log :info, 'test run: rake cucumber'

#gem "rspec", '>= 2.0.0.beta', :group => [:test]
gem "rspec-rails", ">= 2.0.0.beta", :group => [:test]
generate('rspec:install')
in_root do
  run 'bundle install'
end

gem "cucumber-rails", :git => "git://github.com/aslakhellesoy/cucumber-rails.git", :group => [:test]
generate('cucumber:install --capybara --rspec')
in_root do
  run 'bundle install'
end



gem "database_cleaner", :git => 'git://github.com/bmabey/database_cleaner.git', :group => [:test] 

gem "machinist", :git => "git://github.com/notahat/machinist.git", :group => [:test]
gem "faker",:group => [:test]

gem "ZenTest", :group => [:test]
gem "autotest", :group => [:test]
gem "autotest-rails", :group => [:test]
 
#gem "capybara", :group => [:development, :test]
gem "capybara-envjs",:group => [:test]
gem "launchy", :group => [:test]

gem "ruby-debug", :group => [:development, :test]




#TODO add hook for rspec and mongodb

if file_exist?('config/mongoid.yml')
  log :mongodb, 'Add hook cucumber'
  inside('futures/support') do
    file('hooks.rb') do
      <<-TXT
    Mongoid.master.collections.select do |collection|
      collection.name !~ /system/
    end.each(&:drop)
      TXT
    end
  end

end

if yes?('run db:create db:migrate ?')
  rake 'db:create'
  rake 'db:migrate'
end

if yes?('Test cucumber setup?')
  rake 'cucumber',  :env => 'test'
end


