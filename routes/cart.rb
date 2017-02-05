
get '/cart' do
  erb :cart
end

post '/add_to_cart' do
  if is_user_active
    order_item_params = {
                        product_id: params[:product_id],
                        amount: params[:amount],
                        size: params[:size]}

    @order = current_order
    @order_item = @order.order_items.new(order_item_params)
    @order.save
    session[:order_id] = @order.id
  end
  redirect '/cart'
end
