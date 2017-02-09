get '/' do
  erb :home
end

get "/logout" do
  session[:user_name] = nil
  if session[:order_id]
    order_id = session[:order_id]
    order = Order.find(order_id)
    order.update(order_status_id: 4)
    order.order_items.each do |item|
      product = item.product
      amount = product.amount + item.amount
      product.update(amount: amount)
    end
    session[:order_id] = nil
  end
  flash[:success] = "Излязохте успешно. Заповядайте отново!"
  redirect "/"
end
