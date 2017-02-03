
get '/delete_comment' do
  if is_admin == true
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
