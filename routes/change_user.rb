
post '/make_amdin' do
  if is_admin
    user = User.find_by user_name: params[:user_name]
    user.update(admin: true)
    redirect '/all_users'
  end
end

post '/ban_user' do
  if is_admin
    user = User.find_by user_name: params[:user_name]
    user.update(status: 'banned')
    redirect '/all_users'
  end
end

post '/activate_user' do
  if is_admin
    user = User.find_by user_name: params[:user_name]
    user.update(status: 'active')
    redirect '/all_users'
  end
end
