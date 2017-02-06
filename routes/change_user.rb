
post '/make_amdin' do
  if is_admin
    user = User.find_by user_name: params[:user_name]
    user.update(admin: true)
    flash[:success] = "Потрбителят беше успешно повишен до ниво Администратор."
    redirect '/all_users'
  end
end

post '/ban_user' do
  if is_admin
    user = User.find_by user_name: params[:user_name]
    user.update(status: 'banned')
    flash[:success] = 'Потребителят беше баннат успешно.'
    redirect '/all_users'
  end
end

post '/activate_user' do
  if is_admin
    user = User.find_by user_name: params[:user_name]
    user.update(status: 'active')
    flash[:success] = 'Правата за достъп на потребителя'\
                  ' бяха възстановени успешно.'
    redirect '/all_users'
  end
end
