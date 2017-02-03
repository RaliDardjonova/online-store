
get '/open_shoes' do
  if params[:product_id]
    @shoe = Shoe.find_by product_id: params[:product_id].to_i
    erb :open_shoes
  else
    erb :no_permission
  end
end


post '/open_shoes' do
  @shoe = Shoe.find_by product_id: params[:product_id].to_i
  erb :open_shoes
end
