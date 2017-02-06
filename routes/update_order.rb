
post '/update_order' do
  if is_user_active
    order_id = session[:order_id]
    order = Order.find(order_id)
    if params[:update_order] == "2"
      order.update(total: order.subtotal)
      shipping = order.subtotal > 100 ? 0 : 8 - order.subtotal/20
      order.update(shipping: shipping)
      erb :confirm_order
    else
      order.update(order_status_id: 4)
      session[:order_id] = nil
      flash[:success] = "Количката ви беше изпразнена."
      redirect '/cart'
    end
  else
    redirect '/'
  end
end
