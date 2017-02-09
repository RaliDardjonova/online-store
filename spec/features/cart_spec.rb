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

    it 'is not visible for admins' do
      page.set_rack_session(user_name: 'admin')
      visit '/shoes'
      page.find(:xpath, "//tr[2]/td[7]/form").click_button 'Виж повече'
      expect(page).not_to have_content "Добави към количката"
    end

    it 'is visible for non-admin users' do
      page.set_rack_session(user_name: 'pesho')
      visit '/shoes'
      page.find(:xpath, "//tr[2]/td[7]/form").click_button 'Виж повече'
      expect(page).to have_content "Добави към количката"
    end

    it 'is not visible for non-users' do
      visit '/shoes'
      page.find(:xpath, "//tr[2]/td[7]/form").click_button 'Виж повече'
      expect(page).not_to have_content "Добави към количката"
    end
  end

  describe 'adding to cart' do
    let(:user){create :user}
    let(:shoes){create :shoe}
    before do
      user.save
      shoes.save
      page.set_rack_session(user_name: 'pesho')
      visit '/shoes'
      page.find(:xpath, "//tr[2]/td[7]/form").click_button 'Виж повече'
    end

    it 'adds to cart with available amount' do
      select '42.0', from: 'size'
      fill_in 'amount-input', with: 3
      click_button "Добави към количката"
      expect(page).to have_content 'Продуктът беше добавен успешно към количката ви.'
    end

    it 'doesn\'t add to cart if amount is unavailable' do
      select '42.0', from: 'size'
      fill_in 'amount-input', with: 51
      click_button "Добави към количката"
      expect(page).to have_content 'Избраният от вас брой продукти надишава наличността!Моля изберете по-малък брой.'
    end
  end

  describe 'updating cart' do
    let(:user){create :user}
    let(:shoes){create :shoe}
    before do
      user.save
      shoes.save
      page.set_rack_session(user_name: 'pesho')
      visit '/shoes'
      page.find(:xpath, "//tr[2]/td[7]/form").click_button 'Виж повече'
      select '42.0', from: 'size'
      fill_in 'amount-input', with: 3
      click_button "Добави към количката"
      fill_in 'amount-input', with: 2
      click_button "Добави към количката"
      visit '/cart'
    end

    it 'can show products in cart' do
      expect(page).to have_xpath(".//tr", :count => 4)
    end

    it 'can cancel cart' do
      click_button 'Изтрий продуктите от количката'
      expect(page).to have_content 'Количката ви беше изпразнена.'
      expect(page).to have_content 'В момента количката ви е празна.'
    end

    it 'can confirm cart' do
      visit '/cart'
      click_button 'Потвърди поръчката'
      order = Order.find(1)
      expect(page).to have_content 'Потвърждаване на поръчката'
      expect(find_field('email-input').value).to eq(user.email)
      expect(find_field('price-input').value).to eq(order.total.to_s + 'лв')
      expect(find_field('shipping-input').value).to eq('0.0лв')
      fill_in 'address-input', with: 'У село де хълмо'
      click_button 'Завършване на поръчката'
      expect(page).to have_content 'Вашата поръчка беше изпратена за изпълнение.'
      expect(Order.find(1).order_status_id).to eq(2)
    end
  end
end
