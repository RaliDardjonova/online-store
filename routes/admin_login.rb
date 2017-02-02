get '/admin_login' do
  if session[:admin] == true
    erb :admin_login, :layout => false
  else
    erb :no_permission
  end
end

post '/admin_login' do
  isAdmin = params[:admin_permission]
    if isAdmin == "true"
      flash[:success] = "Поздравления! Влезнахте като администратор."
    else
      session[:admin] = false
      flash[:success] = "Поздравления! Влезнахте като потребител."
    end
  redirect '/'
end
