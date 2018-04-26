require 'erb'
require 'tilt'
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
    render_view('index.html')
  end

  def self.about
    render_view('about.html')
  end

  def self.blog
    render_view('blog.html')
  end

  def self.article(path)
    article_id = path.split("/")[2]
    render_view("posts/article#{article_id}.html")
  end

  def self.error
    render_view('posts/error.html', '404')
  end

  def self.css
    render_static('main.css')
  end

  def self.render_view(page, code = '200')
    template = Tilt.new('./app/views/main_template.erb')
    file = File.read("./app/views/#{page}")
    [code, { 'Content-Type' => 'text/html' }, [template.render { file }]]
  end

  def self.render_static_or_error(asset)
    path = "./public#{asset}"
    file = File.exist?(path)
    ext = File.extname(path)
    if file
      case ext
      when '.css' then ['200', { 'Content-Type' => 'text/css' }, [File.read(path)]]
      end
    else
      error
    end 
    # return ['200', { 'Content-Type' => 'text/css' }, [File.read(path)]] if file && ext == '.css'
    # error
  end
end
