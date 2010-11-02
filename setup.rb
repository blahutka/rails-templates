def load_template(template)
  begin
    if @remote
      apply "http://github.com/blahutka/rails-templates/raw/master/#{template}"
      #    code = open(File.join(File.dirname(__FILE__), template)).read
      #    in_root { self.instance_eval(code) }
    else
      unless file_exist?('lib/rails-templates/setup.rb')
        git :clone =>  'git@github.com:blahutka/rails-templates.git lib/rails-templates'
      end
      apply template
    end
  rescue LoadError, Errno::ENOENT => e
    raise "The template [#{template}] could not be loaded. Error: #{e}"
  end
end


def file_exist?(path)
  p = File.join(destination_root, path)  
  if File.exist?(p)
    log :file, "File found: #{p}"
    return true
  else
    log :file, 'File not found' + p
    return false
  end
end

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

if yes?('Scripts from github.com?')
  @remote = true
end

if yes?('Download templates from git?')
  #  run 'mkdir lib/templates'
  git :clone =>  'git@github.com:blahutka/rails-templates.git lib/rails-templates'
end

if yes?('New app setup? (git init, ignore)')
  load_template 'basic.rb'
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