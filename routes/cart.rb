require_relative '../helpers/create_order.rb'

get '/cart' do
  erb :cart
end

post '/add_to_cart' do
    order_item_params = {
                        product_id: params[:product_id],
                        amount: params[:amount],
                        size: params[:size]}

    @order = current_order
    @order_item = @order.order_items.new(order_item_params)
    @order.save
    session[:order_id] = @order.id

  redirect '/cart'
end
