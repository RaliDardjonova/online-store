get '/shoes' do
  erb :shoes
end

post '/open_shoes' do
  @shoe = Shoe.find_by shoes_name: params[:shoes_name]
  erb :open_shoes
end
