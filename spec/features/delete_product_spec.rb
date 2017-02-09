require 'spec_helper'

RSpec.describe "deleting products", type: :feature do
  describe 'access' do
    let(:admin){create :user, user_name: 'admin', admin: true}
    let(:user){create :user}
    let(:shoes){create :shoe}
    before do
      admin.save
      user.save
      shoes.save
    end

    it 'is visible for admins' do
      page.set_rack_session(user_name: 'admin')
      visit '/shoes'
      page.find(:xpath, "//tr[2]/td[7]/form").click_button 'Виж повече'
      expect(page).to have_content "Изтрий продукта"
    end

    it 'is not visible for non-admin users' do
      page.set_rack_session(user_name: 'pesho')
      visit '/shoes'
      page.find(:xpath, "//tr[2]/td[7]/form").click_button 'Виж повече'
      expect(page).not_to have_content "Изтрий продукта"
    end

    it 'is not visible for non-users' do
      visit '/shoes'
      page.find(:xpath, "//tr[2]/td[7]/form").click_button 'Виж повече'
      expect(page).not_to have_content "Изтрий продукта"
    end

    it 'allows admins to delete product' do
      page.set_rack_session(user_name: 'admin')
      visit '/shoes'
      page.find(:xpath, "//tr[2]/td[7]/form").click_button 'Виж повече'
      click_button 'Изтрий продукта'
      expect(page).to have_content "Продуктът беше изтрит успешно"
      expect(Product.find_by product_id: 1).to eq(nil)
    end

    it 'deletes comments when deleting product' do
      comment = create :comment
      comment.save
      page.set_rack_session(user_name: 'admin')
      visit '/shoes'
      page.find(:xpath, "//tr[2]/td[7]/form").click_button 'Виж повече'
      expect(Comment.where(product_id: 1).map{ |c| c.product}).to eq([shoes])
      click_button 'Изтрий продукта'
      expect(Comment.where(product_id: 1)).to eq([])
    end
  end
end
