
post '/update_product' do
  if is_admin
    @product = Product.find_by product_id: params[:product_id]
    case @product.type
    when "Shoe"
      erb :update_shoes
    when "Top"
      erb :update_tops
    when "Trouser"
      erb :update_trousers
    else
      erb :no_permission
    end
  else
    erb :no_permission
  end
end

post '/save_update_product' do
  if is_amdin
    product = Product.find_by product_id: params[:product_id]
    size_min = params[:size_min].to_f
    size_max = params[:size_max].to_f
    changes = {
      product_name: params[:shoes_name],
      description: params[:description],
      price: params[:price],
      size_min: size_min,
      size_max: size_max,
      color: params[:color],
      gender: params[:gender],
      amount: params[:amount],
      category: params[:category]
    }
    product.update(changes)
    redirect "/open_product?product_id=#{params[:product_id]}"
  end
  erb :no_permission
end

post '/delete_product' do
  if is_admin
    product_id = params[:product_id]
    product = Product.find_by product_id: product_id
    product.delete
    Comment.delete_all(product_id: product_id)
    erb :product_is_deleted
  else
    erb :no_permission
  end
end
