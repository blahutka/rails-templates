log :info, 'Clean public files'
stategies << lambda do
  run "rm README"
  run "rm public/index.html"
  run "rm public/favicon.ico"
  run "rm public/images/rails.png"

  file '.gitignore', <<-END
.DS_Store
nbproject
log/*.log
tmp/**/*
config/database.yml
db/*.sqlite3
vendor/rails
  END

  git :init
  git :add => '.'
end