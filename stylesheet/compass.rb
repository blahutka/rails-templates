log :info, 'http://compass-style.org/docs/'
log :info, 'Run compass in rails app folder: compass watch'
gem 'compass', :group => :development
run 'bundle install'

run 'compass init rails'

