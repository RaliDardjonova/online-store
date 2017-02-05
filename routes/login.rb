require_relative '../helpers/create_order.rb'

get '/login' do
  erb :login
end

post '/login' do
  user = User.authenticate(params[:user_name], params[:password])
  if user
    if user.status == 'active'
      session[:user_name] = user.user_name

      flash[:success] = "Поздравления! Успешно влизане."
      redirect '/'
    else
      flash[:error] = "Вашите права са отнети. Не можете да влезнете в момента!"
    end
  else
    flash[:error] = "Грешни име или парола."
  end
  redirect '/login'
end
