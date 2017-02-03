error Sinatra::NotFound do
  content_type 'text/plain'
  [404, 'Not Found']
end
