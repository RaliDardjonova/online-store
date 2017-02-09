
post '/ship_order' do
  if is_admin
    order_id = params[:order_id].to_i
    order = Order.find(order_id)
    order.update(order_status_id: 3)
    flash[:success] = 'Поръчката вече е потвърдена и пусната за изпълнение.'
    redirect '/all_orders'
  end
end
