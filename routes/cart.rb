
get '/cart' do
  erb :cart
end

post '/add_to_cart' do
  if is_user_active
    product = Product.find_by product_id: params[:product_id]
    if params[:amount].to_i > product.amount
      flash[:error] = "Избраният от вас брой продукти надишава наличността!"\
      "Моля изберете по-малък брой."
    else
      order_item_params = {product_id: params[:product_id],
                          amount: params[:amount],
                          size: params[:size]}

      order = current_order
      order_item = order.order_items.new(order_item_params)
      order.save
      left_amount = product.amount - params[:amount].to_i
      product.update(amount: left_amount)
      flash[:success] = "Продуктът беше добавен успешно към количката ви."
      session[:order_id] = order.id
    end
  end
  redirect redirect "/open_product?product_id=#{params[:product_id]}"
end
