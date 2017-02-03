get '/create_user' do
  @users = User.all
  erb :create_user
end

post '/create_user' do
  password_salt = BCrypt::Engine.generate_salt
  password_hash = BCrypt::Engine.hash_secret(params[:password], password_salt)
  password = params[:password]
  if password =~ /[^a-zA-Z0-9_]/
    flash[:error] = "Грешка!Паролата може да съдържа само латински букви, цифри и _."
    redirect '/create_user'
  end
  if password.length < 4
    flash[:error] = "Грешка!Паролата трябва да съдържа минимум 4 знака."
    redirect '/create_user'
  end

  user = User.new(user_name: params[:user_name], email: params[:email], salt: password_salt, password_hash: password_hash, admin: false)
  names = User.all.map{|user| user.user_name}

  if user.valid?
    if names.include? user.user_name
      flash[:error] = "Потребител с това име вече съществува."
      redirect '/create_user'
    else
      flash[:success] = "Поздравления! Вашият акаунт вече е активиран."
      session[:user_name] = params[:user_name]
      user.save
      redirect '/'
    end
  else
    flash[:error] = "Неподхощи данни. #{user.errors.full_messages.to_sentence}"
    redirect '/create_user'
  end
end
