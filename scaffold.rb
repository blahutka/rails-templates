generate(:scaffold, "post", "title:string", "body:text")
append_file 'app/models/post.rb', <<-EOS.gsub(/^ /, '')
 belongs_to :comments
EOS

generate(:scaffold, "price", "title:string", "body:text")

rake 'db:migrate'