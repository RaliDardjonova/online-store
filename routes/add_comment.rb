get '/add_comment' do
  erb :open_shoes
end

post '/add_comment' do
  if is_user_active
    product_id = params[:product_id].to_i
    user_name = session[:user_name]

    comment = Comment.new(user_name: user_name, comment: params[:comment], date_time: DateTime.now, product_id: product_id)
    comment.save
  end
    redirect "/open_shoes?product_id=#{product_id}"
end
