generate(:scaffold, "post", "title:string", "body:text")
set_model :post do
  'class Category < ActiveRecord::Base
    has_and_belongs_to_many :products
  end'
end

file 'app/models/sam.rb', <<-EOS.gsub(/^ /, '')
 class Category < ActiveRecord::Base
   has_and_belongs_to_many :products
 end
EOS

#generate(:scaffold, "price", "title:string", "body:text")

rake 'db:migrate'


def set_model(name, &block)
  name = name.to_s.singularize
  sentinel = /class [a-z_:]+ < ActiveRecord::Base/i
  data = block.call if block_given?

  in_root do
    inject_into_file "app/models/#{name}.rb", "\n #{data}", :after => sentinel, :verbose => false
  end
end