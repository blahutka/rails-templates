def load_template(template)
  begin
    code = open(File.join(File.dirname(__FILE__), template)).read
    in_root { self.instance_eval(code) }
  rescue LoadError, Errno::ENOENT => e
    raise "The template [#{template}] could not be loaded. Error: #{e}"
  end
end

if yes?('Start setup')
  #  run 'mkdir lib/templates'
  git :clone =>  'git@github.com:blahutka/rails-templates.git lib/rails-templates'
end


if yes?('Install MongoDB?')
  load_template 'db/mongo.rb'
end

if yes?('Install Postgre?')
  load_template 'db/postgres.rb'
end