class OrderItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order

  validates :amount, presence: true, numericality: { only_integer: true, greater_than: 0 }

  before_save :finalize

  def unit_price
    if persisted?
      self[:unit_price]
    else
      product.price
    end
  end

  def total_price
    unit_price * amount
  end

private

  def finalize
    self[:unit_price] = unit_price
    self[:total_price] = amount * self[:unit_price]
  end
end
