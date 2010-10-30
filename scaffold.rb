gem 'ParseTree', :require => 'parse_tree'
gem 'ruby2ruby'
gem "simple_form"
gem 'inherited_resources', '1.1.2'

in_root do
  run 'bundle install'
  run 'rvm reload'
  run 'bundle update'
end

require 'rubygems'
require 'parse_tree'
require 'parse_tree_extensions'
require 'ruby2ruby'


def create_model(name, *arr, &block)
  name = name.to_s.singularize
  generate(:scaffold, name, arr.join(' '))
  sentinel = /class [a-z_:]+ < ActiveRecord::Base/i
  data = block.to_ruby.gsub(/(^proc \{)|(\}$)/, '').strip if block_given?

  in_root do
    inject_into_file "app/models/#{name}.rb", "\n #{data}", :after => sentinel, :verbose => false
    log :model, "Model #{name} injectin info"
  end
end

create_model :category, "title:string", "body:text" do
     has_and_belongs_to_many :products
end

create_model :product, "title:string", "body:text" do
     has_and_belongs_to_many :categories
end

generate :scaffold, 'category_id:integer product_id:integer'



rake 'db:migrate'


