gem 'jelly'

stategies << lambda do
  get 'https://github.com/pivotal/jelly/raw/master/generators/jelly/templates/javascripts/jelly.js',
    'public/javascripts/jelly.js'
  get 'https://github.com/pivotal/jelly/raw/master/generators/jelly/templates/javascripts/ajax_with_jelly.js',
    'public/javascripts/ajax_with_jelly.js'
  #generate 'jelly'
  #inject_into_file 'app/views/layouts/application.html.erb', :before => '</head>' do
  #  <<-TXT
  #  <%= javascript_include_tag :only_jelly, *application_jelly_files %>
  #  <%= spread_jelly %>
  #  TXT
  #end
end