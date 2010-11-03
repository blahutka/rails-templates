


if yes?('Run scripts from github.com?')
  @remote = true
  apply("http://github.com/blahutka/rails-templates/raw/master/template_helper.rb")
else
  inside destination_root do
  apply(File.join(destination_root,'lib/rails-templates','template_helper.rb'))
  end
end

initialize_templater

if yes?('testme')
  load_template 'testme.rb'
  execute_stategies
end



if yes?('New app setup? (git init, ignore)')
  load_template 'basic.rb'
end

if yes?('Debugging?')
  if yes?('console default ?')
    load_template 'debugging/console.rb'
  end
end

if yes?('Setup Databases?')
  if yes?('Install MongoDB?')
    load_template 'db/mongo.rb'
  end
  if yes?('Install Postgre?')
    load_template 'db/postgres.rb'
  end
end

if yes?('Setup Plugins?')
  if yes?('Plugin: WillPaginate')
    load_template 'plugin/will_paginate.rb'
  end
  if yes?('Plugin: SimpleForms')
    load_template 'plugin/simple_forms.rb'
  end
  if yes?('Plugin: InheritedResources')
    load_template 'plugin/inherited_resources.rb'
  end
  if yes?('Plugin rails_admin')
    load_template 'plugin/rails_admin.rb'
  end
end

if yes?('Setup Javascripts?')
  if yes?('Use jQuery?')
    load_template 'javascript/jquery.rb'
  end
end

if yes?('Setup Style sheets')
  if yes?('Use Compass')
    load_template 'stylesheet/compass.rb'
  end
end

if yes?('Setup Testing')
  if yes?('Rspec with Cucumber')
    load_template 'testing/rspec.rb'
  end
end