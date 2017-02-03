require_relative '../helpers/create_order.rb'

get '/add_shoes' do
  if is_admin == true
    erb :add_shoes
  else
    erb :no_permission
  end
end

post '/add_shoes' do

  products = Product.all
  if products == []
    product_id = 1
  else
    product_id = products.map { |x| x.product_id}.max + 1
  end

  shoes = Shoe.new(
                  product_name: params[:shoes_name],
                  description: params[:description],
                  price: params[:price],
                  product_id: product_id,
                  size_min: params[:size_min],
                  size_max: params[:size_max],
                  color: params[:color],
                  gender: params[:gender],
                  amount: params[:amount],
                  category: params[:category]
                  )
    flash[:success] = "Добавянето беше успешно."
    shoes.save
    redirect '/add_shoes'
end
