
post '/update_order' do
  if is_user_active
    order_id = session[:order_id]
    order = Order.find(order_id)
    if params[:update_order] == "2"
      order.update(total: order.subtotal)
      order.update(shipping: 5 + order.total/50)
      erb :confirm_order
    else
      order.update(order_status_id: 4)
      session[:order_id] = nil
      redirect '/cart'
    end
  else
    redirect '/'
  end
end
