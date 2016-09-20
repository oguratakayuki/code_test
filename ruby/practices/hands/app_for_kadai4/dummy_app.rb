class DummyApp
  def call(env)
    #[200, {}, ['hello']]
    req = Rack::Request.new(env)
    body = req.fullpath
    url_tree = {
                 a: { aa: {:aaa, :aab, :aac}, ab: {:aba, :abb, :abc} }, 
                 b: { ba: {:baa, :bab, :bac}, bb: {:bba, :bbb, :bbc} }, 
                 c: { ca: {:caa, :cab, :bac}, cb: {:bba, :bbb, :bbc} }, 

    body = body += "<a href='#{link_url}'>link</a>"
    [200, {}, [body]]
  end
end
