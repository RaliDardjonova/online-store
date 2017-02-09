require 'spec_helper'

RSpec.describe "presenting users", type: :feature do
  describe 'access' do
    let(:admin){create :user, user_name: 'admin', admin: true}
    let(:user){create :user}
    let(:status1) {create :order_status, name: "In Progress"}
    let(:status2) {create :order_status, name: "Placed"}
    let(:status3) {create :order_status, name: "Shipped"}
    before do
      admin.save
      user.save
      status1.save
      status2.save
      status3.save
    end
    it 'is visible for admins' do
      page.set_rack_session(user_name: 'admin')
      visit '/'
      expect(page).to have_content 'Поръчки'
    end

    it 'is not visible for non-admin users' do
      page.set_rack_session(user_name: 'pesho')
      visit '/'
      expect(page).not_to have_content 'Поръчки'
    end

    it 'is not visible for non-users' do
      visit '/'
      expect(page).not_to have_content 'Поръчки'
    end

    it 'is allowed for admins' do
      page.set_rack_session(user_name: 'admin')
      visit '/'
      click_link 'Поръчки'
      expect(page).to have_content 'Търси поръчки'
      expect(page).to have_content 'Поръчки'
    end

    it 'is not allowed for non-admin users' do
      page.set_rack_session(user_name: 'pesho')
      visit '/all_orders'
      expect(page).to have_content 'За да достъпите тази страница трябва да имате администраторски права'
    end

    it 'is not allowed for non-users' do
      visit '/all_orders'
      expect(page).to have_content 'За да достъпите тази страница трябва да имате администраторски права'
    end
  end

  describe 'search orders' do
    let(:admin){create :user, user_name: 'admin', admin: true}
    let(:user){create :user}
    let(:user2){create :user, user_name: 'gosho'}
    let(:order){create :order, order_status_id: 2}
    let(:order2){create :order, order_status_id: 3, user_name: 'gosho'}
    let(:shoes){create :shoe}

    let(:order_item){create :order_item, amount: 2}
    let(:order_item2){create :order_item, amount: 3}
    let(:status1) {create :order_status, name: "In Progress"}
    let(:status2) {create :order_status, name: "Placed"}
    let(:status3) {create :order_status, name: "Shipped"}
    before do
      admin.save
      user.save
      user2.save
      status1.save
      status2.save
      status3.save
      shoes.save
      order.order_items.push(order_item)
      order.save
      order.update(shipping: 0, total: order.subtotal)
      order2.order_items.push(order_item2)
      order2.save
      order2.update(shipping: 0, total: order2.subtotal)
      page.set_rack_session(user_name: 'admin')
      visit '/all_orders'
    end
    it 'shows all orders' do
      expect(page).to have_xpath(".//tr", :count => 3)
    end

    it 'shows in order of update' do
      expect(page.find(:xpath, "//tr[2]/td[1]")).to have_content 1
      expect(page.find(:xpath, "//tr[3]/td[1]")).to have_content 2
      expect(page.find(:xpath, "//tr[2]/td[3]")).to have_content order.total.to_s + 'лв'
      expect(page.find(:xpath, "//tr[3]/td[3]")).to have_content order2.total.to_s + 'лв'
    end

    it 'can search by order status' do
      select 'Чакащи потвърждение', :from => 'order_status'
      click_button 'Търси'
      expect(page).to have_xpath(".//tr", :count => 2)
      expect(page.find(:xpath, "//tr[2]/td[1]")).to have_content 1
      expect(page.find(:xpath, "//tr[2]/td[3]")).to have_content order.total.to_s + 'лв'
    end

    it 'can search by user name' do
      fill_in "user-name-input", with: 'gosho'
      click_button 'Търси'
      expect(page).to have_xpath(".//tr", :count => 2)
      expect(page.find(:xpath, "//tr[2]/td[1]")).to have_content 2
      expect(page.find(:xpath, "//tr[2]/td[3]")).to have_content order2.total.to_s + 'лв'
    end

    it 'it can search and display there are no orders with such data' do
      fill_in "user-name-input", with: 'pesho'
      select 'Завършени', :from => 'order_status'
      click_button 'Търси'
      expect(page).to have_content 'Все още няма поръчки'
    end

    it 'can confirm pending order' do
      page.find(:xpath, "//tr[2]/td[6]/form").click_button 'Виж повече'
      expect(page).to have_content 'Данни за поръчка'
      click_button 'Потвърди поръчката за изпълнение'
      expect(page).to have_content 'Поръчката вече е потвърдена и пусната за изпълнение.'
      select 'Завършени', :from => 'order_status'
      click_button 'Търси'
      expect(page).to have_xpath(".//tr", :count => 3)
    end
  end
end
