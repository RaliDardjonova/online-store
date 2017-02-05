
get '/all_orders' do
  if is_admin
    params[:user_name] = ""
    params[:order_status] = "0"
    erb :all_orders
  else
    erb :no_permission
  end
end

post '/all_orders' do

end
