log :javascript, 'settup jQuery'
gem "jquery-rails"

stategies << lambda do
  generate 'jquery:install --ui' #--ui to enable jQuery UI --version to install specific version of JQuery (default is 1.4.2)
  
  #  inside('public/javascripts') do
  #    FileUtils.rm_rf %w(controls.js dragdrop.js effects.js prototype.js rails.js)
  #  end
  #
  #  get "http://code.jquery.com/jquery-latest.min.js", "public/javascripts/jquery.js"
  #  get "http://github.com/rails/jquery-ujs/raw/master/src/rails.js", "public/javascripts/rails.js"
  #  initializer 'jquery.rb', <<-CODE
  #    ActionView::Helpers::AssetTagHelper.register_javascript_expansion :jquery => ['jquery', 'rails']
  #    ActiveSupport.on_load(:action_view) do
  #    ActiveSupport.on_load(:after_initialize) do
  #      ActionView::Helpers::AssetTagHelper::register_javascript_expansion :defaults => ['jquery', 'rails']
  #      end
  #    end
  #CODE
end