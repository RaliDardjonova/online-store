

post '/confirm_order' do
  order_id = session[:order_id]
  order = Order.find(order_id)
  if params[:confirm_order] == "2"
    order.update(order_status_id: 2)
    session[:order_id] = nil
    redirect '/cart'
  else
    order.update(order_status_id: 4)
    session[:order_id] = nil
    redirect '/cart'
  end
end
