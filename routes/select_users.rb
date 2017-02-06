
get '/select_users' do
  if is_admin && params[:user_name] && params[:user_status] && params[:is_admin]
    erb :all_users
  else
    erb :no_permission
  end
end
