
get '/all_users' do
  if is_admin
    params[:user_name] = ""
    params[:user_status] = "all"
    params[:is_admin] = "all"
    erb :all_users
  else
    erb :no_permission
  end
end
