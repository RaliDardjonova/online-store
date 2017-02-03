get '/' do
  erb :home
end

get "/logout" do
  session[:user_name] = nil
  if session[:order_id]
    order_id = session[:order_id]
    Order.find(order_id).update(order_status_id: 4)
    session[:order_id] = nil
  end
  flash[:success] = "Излязохте успешно. Заповядайте отново!"
  redirect "/"
end
