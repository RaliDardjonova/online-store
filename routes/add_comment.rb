get '/add_comment' do
  erb :open_shoes
end

post '/add_comment' do
  product_id = params[:product_id].to_i

  if session[:admin]
    user_name = session[:user_name] + " (Администратор)"
  else
    user_name = session[:user_name]
  end

  comment = Comment.new(user_name: user_name, comment: params[:comment], date_time: DateTime.now, product_id: product_id)
  comment.save

  redirect "/open_shoes?product_id=#{product_id}"
end
