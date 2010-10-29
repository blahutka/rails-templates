#generate(:scaffold, "post", "title:string", "body:text")
gsub_file 'app/models/post.rb', <<-EOS.gsub(/Base/, '')

belongs_to :comments
EOS

#generate(:scaffold, "price", "title:string", "body:text")

rake 'db:migrate'