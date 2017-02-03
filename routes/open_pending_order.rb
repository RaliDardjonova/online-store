
get '/open_pending_order' do
  if is_admin && params[:order_id]
    erb :open_pending_order
  else
    erb :no_permission
  end
end

post '/open_pending_order' do

end
