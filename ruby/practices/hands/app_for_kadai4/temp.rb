    url_tree = {
                 a: { aa: {aaa: nil, aab: nil, aac: nil}, ab: {aba: nil, abb: nil, abc: nil} }, 
                 b: { ba: {baa: nil, bab: nil, bac: nil}, bb: {bba: nil, bbb: nil, bbc: nil} }, 
                 c: { ca: {caa: nil, cab: nil, bac: nil}, cb: {bba: nil, bbb: nil, bbc: nil} }, 
               }

#    body = body += "<a href='#{link_url}'>link</a>"
path = '/a/ab'
path = path.split('/').reject{|t| t == ''}.map(&:to_sym)
ret = url_tree
path.each do |key|
  ret = ret[key]
end
puts ret
 
ret.each do |temp|
  puts "<a href='#{current_path}'>hoge</a>"
end
