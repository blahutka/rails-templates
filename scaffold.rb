require 'rubygems'
require 'parse_tree'
require 'parse_tree_extensions'
require 'ruby2ruby'


def create_model(name, *arr, &block)
  name = name.to_s.singularize
  generate(:scaffold, name, arr)
  sentinel = /class [a-z_:]+ < ActiveRecord::Base/i
  data = block.to_ruby.gsub(/(^proc \{)|(\}$)/, '').strip if block_given?

  in_root do
    inject_into_file "app/models/#{name}.rb", "\n #{data}", :after => sentinel, :verbose => false
    log :model, "Model #{name} injectin info"
  end
end

create_model :category, "title:string", "body:text" do
     has_and_belongs_to_many :product
end

create_model :product, "title:string", "body:text" do
     has_and_belongs_to_many :category
end

create_model :category_product, "category_id:integer", "product_id:integer" do
     belongs_to :product
     belongs_to :category
end


rake 'db:migrate'


