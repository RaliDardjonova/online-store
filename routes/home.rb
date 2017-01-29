get '/' do
  @users = User.all
  @shoes = Shoe.all
  @tops = Top.all
  @products = @shoes + @tops
  erb :home
end

helpers do
  def login?
      session[:user_name].nil? ? false : true
  end
end

get "/logout" do
  session[:user_name] = nil
  flash[:success] = "Излязохте успешно. Заповядайте отново!"
  redirect "/"
end
