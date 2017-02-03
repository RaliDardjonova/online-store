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

  def create
    @order = current_order
    @order_item = @order.order_items.new(order_item_params)
    @order.save
    session[:order_id] = @order.id
  end

  def update
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.update_attributes(order_item_params)
    @order_items = @order.order_items
  end

  def destroy
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    @order_items = @order.order_items
  end

  def order_item_params
    params.require(:order_item).permit(:quantity, :product_id)
  end

  def show
   @order_items = current_order.order_items
 end
end
