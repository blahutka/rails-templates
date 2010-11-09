


if yes?('Run scripts from github.com?')
  @remote = true
  apply("http://github.com/blahutka/rails-templates/raw/master/template_helper.rb")
else
  inside destination_root do
    apply(File.join(File.dirname(__FILE__), 'template_helper.rb'))
  end
end

initialize_templater

if yes?('New app setup? (public clean, git setup)')
  load_template 'basic.rb'
end

if yes?('Databases?: ')
  if yes?('MongoDB?: ')
    load_template 'db/mongo.rb'
  end
  if yes?('Postgres?: ')
    load_template 'db/postgres.rb'
  end
end

if yes?('Plugins?')
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

if yes?('Permissions?:')
  if yes?('Device, CenCan, Mongoid')
    load_template 'permission/cream.rb'
  end
end

if yes?('Javascripts?')
  if yes?('jQuery?')
    load_template 'javascript/jquery.rb'
  end
end

if yes?('Stylesheets')
  if yes?('Compass ruby stylesheet tools')
    load_template 'stylesheet/compass.rb'
  end

  if yes?('Elastic css framework')
    load_template 'stylesheet/elastic.rb'
  end
end

if yes?('Testing?')
  if yes?('Rspec, Cucumber')
    load_template 'testing/rspec.rb'
  end
end

if yes?('Debugging?')
  if yes?('console default ?')
    load_template 'debugging/console.rb'
  end
end

if yes? 'RUN ALL'
  in_root do
    gsub_file 'Gemfile', /gem "".*/, '' #remove empty gem
    run 'bundle install'
    run 'bundle update'
  end

  execute_stategies
end