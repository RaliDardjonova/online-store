require 'spec_helper'

RSpec.describe Order do
  describe 'calculating fields' do
    let(:product){create :shoe}

    let(:order) {build :order}
    before{product.save}

    it 'sets order status ' do
      expect(order[:order_status_id]).to eq(nil)
      expect(order.send(:set_order_status)).to eq(1)
      expect(order[:order_status_id]).to eq(1)
    end

    it 'sets order status when saving' do
      expect(order[:order_status_id]).to eq(nil)
      order.save
      expect(order[:order_status_id]).to eq(1)
    end

    it 'calculates subtotal' do
      order_item1 = create :order_item, amount: 3
      expect(order.subtotal).to eq(0)
      order.order_items.push(order_item1)
      expect(order.subtotal).to eq(180)

      product.update(price: 50)
      order_item2 = create :order_item, amount: 2
      order.order_items.push(order_item2)
      expect(order.subtotal).to eq(280)
    end
  end
end
