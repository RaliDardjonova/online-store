
get '/open_shoes' do
  @shoe = Shoe.find_by product_id: params[:product_id].to_i
  erb :open_shoes
end


post '/open_shoes' do
  @shoe = Shoe.find_by product_id: params[:product_id].to_i
  erb :open_shoes
end
