get '/add_product' do
  if is_admin == true
    erb :add_product
  else
    erb :no_permission
  end
end

post '/add_product' do
  products = Product.all
  if products == []
    product_id = 1
  else
    product_id = products.map { |x| x.product_id}.max + 1
  end
  if params[:size_min] > params[:size_max]
    flash[:error] = "Грешка. Минималният размер е по-голям от максималния!"
    redirect '/add_product'
  else
    size_min = params[:size_min].to_f
    size_max = params[:size_max].to_f
    product = Product.new(
                    product_name: params[:product_name],
                    description: params[:description],
                    price: params[:price],
                    product_id: product_id,
                    size_min: size_min,
                    size_max: size_max,
                    color: params[:color],
                    gender: params[:gender],
                    amount: params[:amount],
                    category: params[:category],
                    type: params[:type]
                    )
    flash[:success] = "Добавянето на продукта беше успешно."
    product.save
    redirect '/add_product'
  end
end


get '/add_chosen_product' do
  if is_admin
    case params[:type]
    when "Shoe"
      erb :add_shoes
    when "Trouser"
      erb :add_trousers
    when "Top"
      erb :add_tops
    when ""
      redirect '/add_product'
    else
      erb :no_permission
    end
  end
end
