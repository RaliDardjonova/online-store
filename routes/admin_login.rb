get '/admin_login' do
  erb :admin_login
end

post '/admin_login' do
  admin = Admin.authenticate(params[:user_name], params[:password1], params[:password2])
  if admin
    session[:user_name] = 'admin'
    flash[:success] = "Поздравления! Влезнахте като администратор."
    redirect '/'
  else
    flash[:error] = "Грешни име или парола."
  end
  redirect '/admin_login'
end
