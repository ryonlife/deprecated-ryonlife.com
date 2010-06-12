get "/" do
  set_common_variables
  set_from_config(:title, :subtitle, :description, :keywords)
  @heading = @title
  @title = @title
  @articles = Page.find_articles[0..7]
  @body_class = "home"
  cache haml(:index)
end

get "/blog" do
  set_common_variables
  set_from_config(:title, :subtitle, :description, :keywords)
  @heading = "Blog"
  @title = "Blog"
  @articles = Page.find_articles[0..999]
  cache haml(:blog)
end