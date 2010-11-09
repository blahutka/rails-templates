log :javascript, 'settup jQuery'

stategies << lambda do
  inside('public/javascripts') do
    FileUtils.rm_rf %w(controls.js dragdrop.js effects.js prototype.js rails.js)
  end

  get "http://code.jquery.com/jquery-latest.min.js", "public/javascripts/jquery.js"
  get "https://github.com/rails/jquery-ujs/raw/master/src/rails.js", "public/javascripts/rails.js"
  initializer 'jquery.rb', <<-CODE
    ActionView::Helpers::AssetTagHelper.register_javascript_expansion :jquery => ['jquery', 'rails']
    ActiveSupport.on_load(:action_view) do
    ActiveSupport.on_load(:after_initialize) do
      ActionView::Helpers::AssetTagHelper::register_javascript_expansion :defaults => ['jquery', 'rails']
      end
    end
  CODE
end