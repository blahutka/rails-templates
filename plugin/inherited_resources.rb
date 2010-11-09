gem 'inherited_resources', '1.1.2'
gem 'has_scope'

stategies << lambda do
  gsub_file 'app/controllers/application_controller.rb', /.*end/ do
    <<-TXT
      inherit_resources
    end
    TXT
  end
end
