require 'rack'

class PersonalSite
  def self.call(env)
    case env['PATH_INFO']
    when '/' then index
    when '/about' then about
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

  def self.error
    render_view('error.html', '404')
  end

  def self.css
    render_static('main.css')
  end

  def self.render_view(page, code = '200')
    [code, {'Content-Type' => 'text/html'}, [File.read("./app/views/#{page}")]]
  end

  def self.render_static_or_error(asset)
    path = "./public#{asset}"
    file = File.exist?(path)
    ext = File.extname(path)
    return ['200', { 'Content-Type' => 'text/css' }, [File.read(path)]] if file && ext == '.css'
    error
  end
end
