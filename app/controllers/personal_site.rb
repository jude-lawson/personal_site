require 'rack'

class PersonalSite
  def self.call(env)
    case env['PATH_INFO']
    when '/' then index
    when '/about' then about
    else
      error
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

  def self.render_view(page, code = '200', root_path = 'app/views')
    [code, {'Content-Type' => 'text/html'}, [File.read("./#{root_path}/#{page}")]]
  end
end
