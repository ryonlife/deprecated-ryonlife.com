helpers do
  def background_image
    path = File.join(Nesta::Configuration.attachment_path, "backgrounds", File::SEPARATOR)
    default = "#{path}index.jpg"
    return default if @page.nil?
    image = "#{path}#{@page.path}.jpg"
    File.exist?(image) ? image : default
  end
  
  def background_credit
    credits = File.join(Nesta::Configuration.attachment_path, "backgrounds", "credits.yml")
    @@yaml ||= YAML::load(IO.read(credits))
    (@page.nil? or @@yaml[@page.path].nil?) ? @@yaml["index"] : @@yaml[@page.path]
  end
end

get '/' do
  set_common_variables
  set_from_config(:title, :subtitle, :description, :keywords)
  @heading = @title
  @title = @title
  @articles = Page.find_articles[0..7]
  @body_class = 'home'
  cache haml(:index)
end

get '/blog' do
  set_common_variables
  set_from_config(:title, :subtitle, :description, :keywords)
  @heading = 'Blog'
  @title = 'Blog'
  @articles = Page.find_articles[0..999]
  cache haml(:blog)
end