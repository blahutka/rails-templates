log :info, 'Elastic css'

stategies << lambda do
  get "https://github.com/azendal/elastic/raw/master/production/elastic.css", "public/stylesheets/elastic/elastic.css"
  get "https://github.com/azendal/elastic/raw/master/production/elastic.print.css", "public/stylesheets/elastic/elastic.print.css"
  get "https://github.com/azendal/elastic/raw/master/production/elastic.js", "public/javascripts/elastic/elastic.js"

  initializer 'elastic.rb' do
    <<-TXT
  ActionView::Helpers::AssetTagHelper.register_javascript_expansion :elastic => ["elastic/elastic.js"]

  ActionView::Helpers::AssetTagHelper.register_stylesheet_expansion :elastic => ['elastic/elastic.css']
  ActionView::Helpers::AssetTagHelper.register_stylesheet_expansion :elastic_print => ['elastic/elastic.print.css']
    TXT
  end

  gsub_file('app/views/layouts/application.html.erb', /(javascript_include_tag :defaults)/,'\1, :elastic')
end