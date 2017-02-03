get '/delete_comment' do
  isAdmin = false
  user = User.find_by user_name: session[:user_name]
  isAdmin = user.admin if user.respond_to? :admin
  if isAdmin == true
    erb :open_shoes
  else
    erb :no_permission
  end
end

post '/delete_comment' do
  comment_id = params[:comment_id].to_i
  product_id = Comment.find(comment_id).product_id

  Comment.delete(comment_id)

  redirect "/open_shoes?product_id=#{product_id}"
end
