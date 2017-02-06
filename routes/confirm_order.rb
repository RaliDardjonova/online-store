

post '/confirm_order' do
  if is_user_active
    order_id = session[:order_id]
    order = Order.find(order_id)
    order.update(address: params[:address])
    
    if params[:confirm_order] == "2"
      order.update(order_status_id: 2)
      session[:order_id] = nil
      flash[:success] = "Вашата поръчка беше изпратена за изпълнение."
      redirect '/cart'
    else
      order.update(order_status_id: 4)
      session[:order_id] = nil
      redirect '/cart'
    end
  else
    redirect '/'
  end
end
