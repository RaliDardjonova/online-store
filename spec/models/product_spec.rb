require 'spec_helper'

RSpec.describe Product do
  describe 'operating with product' do
    let(:product){create :top}
    before{ product.save }
    it 'can add product successfully' do
      expect(Product.find_by product_id: 1).to eq(product)
    end

    it 'can update product successfully' do
      product.update(price: 20)
      expect((Product.find_by product_id: 1).price).to eq(20)
      product.update(color: 'red')
      expect((Product.find_by product_id: 1).color).to eq('red')
    end

    it 'can delete product successfully' do
      product.delete
      expect(Product.find_by product_id: 1).to eq(nil)
    end
  end
end
