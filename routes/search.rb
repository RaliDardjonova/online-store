

get '/search' do
  params[:product_name] = ""
  params[:color] = ""
  params[:gender] = ""
  params[:category] = ""
  params[:type] = ""
  params[:price] = ""
  params[:size] =  ""

  erb :search
end

get '/select_products' do
    erb :search
end
