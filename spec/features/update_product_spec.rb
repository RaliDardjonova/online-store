require 'spec_helper'

RSpec.describe "updating products", type: :feature do
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
      expect(page).to have_content "Промени продукта"
    end

    it 'is not visible for non-admin users' do
      page.set_rack_session(user_name: 'pesho')
      visit '/shoes'
      page.find(:xpath, "//tr[2]/td[7]/form").click_button 'Виж повече'
      expect(page).not_to have_content "Промени продукта"
    end

    it 'is not visible for non-users' do
      visit '/shoes'
      page.find(:xpath, "//tr[2]/td[7]/form").click_button 'Виж повече'
      expect(page).not_to have_content "Промени продукта"
    end

    it 'allows admins to enter' do
      page.set_rack_session(user_name: 'admin')
      visit '/shoes'
      page.find(:xpath, "//tr[2]/td[7]/form").click_button 'Виж повече'
      click_button 'Промени продукта'
      expect(page).to have_content "Промяна на обувки"
    end
  end

  describe 'sending the form' do
    let(:admin){create :user, user_name: 'admin', admin: true}
    let(:shoes){create :shoe}
    before do
      admin.save
      shoes.save
      page.set_rack_session(user_name: 'admin')
      visit '/shoes'
      page.find(:xpath, "//tr[2]/td[7]/form").click_button 'Виж повече'
      click_button 'Промени продукта'
    end

    it 'has a form filled with product specifications' do
      expect(find_field('shoes-name-input').value).to eq(shoes.product_name)
      expect(find_field('description-input').value).to eq(shoes.description)
      expect(find_field('price-input').value).to eq(shoes.price.to_s)
      expect(find_field('size-input-min').value).to eq(shoes.size_min.to_s)
      expect(find_field('size-input-max').value).to eq(shoes.size_max.to_s)
      expect(find_field("color-input",with: 'white')).to be_checked
      expect(find_field("gender-input", with: 'men')).to be_checked
      expect(find_field("category-input", with: 'sport')).to be_checked
      expect(find_field('amount-input').value).to eq(shoes.amount.to_s)
    end

    it 'can change product' do
      fill_in 'description-input', with: 'Сменено описание'
      page.choose("color-input", option: 'purple')
      click_button 'Запиши'
      expect(page).to have_content 'Продуктът беше променен успешно.'
      expect(page).to have_content 'Сменено описание'
      expect(page).to have_content 'Лилав'
    end
  end
end
