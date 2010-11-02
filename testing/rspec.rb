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


if yes?('Run db:migrate ?')
  rake 'db:create'
  rake 'db:migrate'
end

if yes?('Test cucumber setup?')
  rake 'cucumber',  :env => 'test'
end


