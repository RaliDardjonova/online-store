
get '/open_order' do
  if is_admin && params[:order_id]
    erb :open_order
  else
    erb :no_permission
  end
end

get '/select_orders' do
  if is_admin && params[:user_name] && params[:order_status]
    erb :all_orders
  else
    erb :no_permission
  end
end
