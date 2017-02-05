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
    isActive = user.status if user.respond_to? :status
    if isActive == 'banned'
      false
    else
      isAdmin
    end
  end

  def is_user_active
    user = User.find_by user_name: session[:user_name]
    is_active = user.status if user.respond_to? :status
    is_active == 'active'
  end

  def get_colour order
    if order.order_status_id == 2
      "#ffe699;"
    else
      "#a8db70;"
    end
  end

  def get_status order
    if order.order_status_id == 2
      "Чакаща потвърждение"
    else
      "Завършена"
    end
  end

  def get_orders(order_status, user_name)
    pending_orders = OrderStatus.find(2).orders
    finished_orders = OrderStatus.find(3).orders
    all_orders = pending_orders + finished_orders
    all_orders = all_orders.sort_by { |hsh| hsh[:updated_at] }
    sellected_orders = all_orders.select{ |order| order.user_name == user_name}

    case order_status
    when "0"
      get_orders_by_name user_name, all_orders
    when "2"
      get_orders_by_name user_name, pending_orders
    when "3"
      get_orders_by_name user_name, finished_orders
    else []
    end
  end

  def get_orders_by_name(user_name, orders)
    if user_name == ""
      orders
    else
      orders.select{ |order| order.user_name == user_name}
    end
  end

  def get_user_status(user)
    if user.admin == true
      "Администратор"
    else
      "Потербител"
    end
  end

  def get_users_by_name_status_isadmin (user_name, status, is_admin)
    user = User.find_by user_name: user_name
    if user_name == ""
      get_users_by_status_isadmin(User.all, status, is_admin)
    elsif user
      user.admin == str_true?(is_admin) && user.status == status ? [user] : []
    else
      []
    end
  end

  def get_users_by_status_isadmin (all_users, status, is_admin)
    if status == 'all'
      is_admin == 'all' ? all_users : User.where({admin: str_true?(is_admin)})
    elsif is_admin == "all"
      User.where({status: status})
    else
      User.where({status: status, admin: str_true?(is_admin)})
    end
  end

  def str_true?(str)
    str == "true"
  end

  def get_products_by_price(group)
    case group
    when "1"
      Product.where("price < 50")
    when "2"
      Product.where("price >= 50") & Product.where("price < 100")
    when "3"
      Product.where("price >= 100") & Product.where("price < 200")
    when "4"
      Product.where("price >= 200")
    else
      Product.all
    end
  end

  def get_products(hash, size, check_min_size, check_max_size, price)
    hash = hash.select{|_, value| value != "" &&  value != nil}
    if size == nil || size == ""
      Product.where(hash) & get_products_by_price(price)
    else
      Product.where(check_min_size) & Product.where(check_max_size) & Product.where(hash) & get_products_by_price(price)
    end
  end

  def tops_sizes(number)
    hash_sizes = {
      '1' => 'XS',
      '2' => 'S',
      '3' => 'M',
      '4' => 'L',
      '5' => 'XL',
      '6' => 'XXL'
    }
    hash_sizes[number.to_i.to_s]
  end

  def get_product_sizes(product)
    case product.type
    when "Shoe"
      range = ((product.size_min*2).to_i..(product.size_max*2).to_i).to_a
      range = range.map{|number| (number.to_f/2).to_s }
    when "Top"
      range = ((product.size_min.to_i)..(product.size_max.to_i)).to_a
      range = range.map{|number| tops_sizes number }
    else
      []
    end
  end
end
