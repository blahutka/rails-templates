#tes
if yes?('Start setup')
  #  run 'mkdir lib/templates'
  git :clone =>  'git@github.com:blahutka/rails-templates.git lib/templates'
end


if yes?('Install MongoDB?')
  require 'mongodb'
end