get '/' do
  @users = User.all
  @shoes = Shoe.all
  @tops = Top.all
  @products = @shoes + @tops
  erb :home
end



get "/logout" do
  session[:user_name] = nil
  session[:admin] = false
  flash[:success] = "Излязохте успешно. Заповядайте отново!"
  redirect "/"
end
