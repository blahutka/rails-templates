#generate(:scaffold, "post", "title:string", "body:text")
gsub_file 'app/models/post.rb', <<-EOS.gsub(/^ /im, '')
 class Category < ActiveRecord::Base
   has_and_belongs_to_many :products
 end
EOS

file 'app/models/sam.rb', <<-EOS.gsub(/^ /, '')
 class Category < ActiveRecord::Base
   has_and_belongs_to_many :products
 end
EOS

#generate(:scaffold, "price", "title:string", "body:text")

rake 'db:migrate'