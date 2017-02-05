
get '/open_product' do
  if params[:product_id]
    @product = Product.find_by product_id: params[:product_id].to_i
    erb :open_product
  else
    erb :no_permission
  end
end


post '/open_product' do
  @product = Product.find_by product_id: params[:product_id].to_i
  erb :open_product
end
