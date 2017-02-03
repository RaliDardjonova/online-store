
get '/pending_orders' do
  if is_admin
    erb :pending_order
  else
    erb :no_permission
  end
end

post '/pending_orders' do

end
