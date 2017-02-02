get '/login' do
  erb :login
end

post '/login' do
  user = User.authenticate(params[:user_name], params[:password])
  if user
    user
    session[:user_name] = user.user_name
    session[:admin] = user.admin
    if user.admin == true
      redirect '/admin_login'
    else
      flash[:success] = "Поздравления! Успешно влизане."
      redirect '/'
    end
  else
    flash[:error] = "Грешни име или парола."
  end
  redirect '/login'
end
