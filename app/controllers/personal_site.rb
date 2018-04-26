require 'erb'
require 'haml'
require 'tilt/haml'
require 'rack'

class PersonalSite

  def self.call(env)
    case env['PATH_INFO']
    when '/' then index
    when '/about' then about
    when '/blog' then blog
    when %r{/blog/\d} then article(env['PATH_INFO'])
    else
      render_static_or_error(env['PATH_INFO'])
    end
  end

  def self.index
    render_view('index.haml')
  end

  def self.about
    render_view('about.haml')
  end

  def self.blog
    render_view('blog.haml')
  end

  def self.article(path)
    article_id = path.split('/')[2]
    render_view("posts/article#{article_id}.haml")
  end

  def self.error
    render_view('error.haml', '404')
  end

  def self.css
    render_static('main.css')
  end

  def self.render_view(page, code = '200')
    template = Tilt::HamlTemplate.new('./app/views/main_template.haml')
    file = Haml::Engine.new(File.read("./app/views/#{page}")).render
    [code, { 'Content-Type' => 'text/html' }, [template.render { file }]]
  end

  def self.render_static_or_error(asset)
    path = "./public#{asset}"
    file = File.exist?(path)
    ext  = File.extname(path)
    if file
      case ext
      when '.css' then ['200', { 'Content-Type' => 'text/css' }, [File.read(path)]]
      end
    else
      error
    end
  end
end
