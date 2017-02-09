require 'spec_helper'

RSpec.describe OrderItem do
  describe 'calculating order item' do
  let(:product){create :shoe}
    before {product.save}

    it 'calculates unit price' do
      item = create :order_item, amount: 3
      expect(item.unit_price).to eq(product.price)
    end

    it 'calculates total price' do
      item = create :order_item, amount: 3
      expect(item.total_price).to eq(180)
    end

    it "doesn't change price, when product price changes" do
      item = create :order_item
      expect(item.unit_price).to eq(product.price)
      product.update(price: 55)
      expect(item.unit_price).to eq(60)
    end
  end

  describe 'creating order item' do
    let(:product){create :shoe}
    let(:order){create :order}
    before do
    order.save
    product.save
    end

    it 'saves coorect order item' do
      item = create :order_item
      item.save
      expect(OrderItem.find(1)).to eq(item)
    end

    it 'doesn\'t save item with negative amount' do
      item = build :order_item, amount: -1
      expect(item).not_to be_valid
    end

    it 'finds its product' do
        item = create :order_item
        expect(item.product).to eq(product)
    end

    it 'finds its order' do
      item = create :order_item
      expect(item.order).to eq(order)
    end
  end
end
