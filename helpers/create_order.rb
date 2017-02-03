helpers do
  def current_order
    if !session[:order_id].nil?
      Order.find(session[:order_id])
    else
      Order.new(user_name: get_user_name)
    end
  end

  def get_user_name
    session[:user_name]
  end

  def is_admin
    isAdmin = false
    user = User.find_by user_name: session[:user_name]
    isAdmin = user.admin if user.respond_to? :admin
    isAdmin
  end
end
