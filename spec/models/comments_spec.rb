require 'spec_helper'

RSpec.describe Comment do
  describe 'creating comment' do
    let(:product) {create :top}
    let(:comment) {create :comment}
    before do
      product.save
      comment.save
    end
    it 'can have a product' do
      expect(comment.product).to eq(product)
    end

    it 'saves it in the database' do
      expect(Comment.find(1)).to eq(comment)
    end
  end
end
