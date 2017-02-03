require_relative '../helpers/create_order'

class Order < ActiveRecord::Base

  belongs_to :order_status
  has_many :order_items
  before_create :set_order_status
  before_save :update_subtotal

  def subtotal
    order_items.collect { |oi| oi.valid? ? (oi.amount * oi.unit_price) : 0 }.sum
  end

  private
  def set_order_status
    self.order_status_id = 1 if self.order_status_id.nil?
  end

  def update_subtotal
    self[:subtotal] = subtotal
  end
end
