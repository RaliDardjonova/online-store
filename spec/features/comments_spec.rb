require 'spec_helper'

RSpec.describe "comments", type: :feature do
  describe 'adding comments' do
    let(:admin){create :user, user_name: 'admin', admin: true}
    let(:user){create :user}
    let(:shoes){create :shoe}
    before do
      admin.save
      user.save
      shoes.save
    end

    it 'allows admins to write comments' do
      page.set_rack_session(user_name: 'admin')
      visit '/shoes'
      page.find(:xpath, "//tr[2]/td[7]/form").click_button 'Виж повече'
      fill_in 'comment-input', with: 'Коментар на администратор'
      click_button 'Изпрати коментара'
      expect(page).to have_content "Коментарът ви беше приет успешно."
      expect(page.find(:xpath, "//tr[1]/td[1]")).to have_content 'admin (Администратор)'
      expect(page.find(:xpath, "//tr[1]/td[2]")).to have_content 'Коментар на администратор'
    end

    it 'allows non-admins users to write comments' do
      page.set_rack_session(user_name: 'pesho')
      visit '/shoes'
      page.find(:xpath, "//tr[2]/td[7]/form").click_button 'Виж повече'
      fill_in 'comment-input', with: 'Коментар на потребител'
      click_button 'Изпрати коментара'
      expect(page).to have_content "Коментарът ви беше приет успешно."
      expect(page.find(:xpath, "//tr[1]/td[1]")).to have_content 'pesho'
      expect(page.find(:xpath, "//tr[1]/td[2]")).to have_content 'Коментар на потребител'
    end

    it 'doesn\'t allow non-users to write comments' do
      visit '/shoes'
      page.find(:xpath, "//tr[2]/td[7]/form").click_button 'Виж повече'
      expect(page).to have_content "За да пишете коментари, трябва да си влезете в профила или да си създадете нов."
    end
  end

  describe 'deleting comments' do
    let(:admin){create :user, user_name: 'admin', admin: true}
    let(:user){create :user}
    let(:shoes){create :shoe}
    let(:comment) {create :comment}
    before do
      admin.save
      user.save
      shoes.save
      comment.save
    end

    it 'is visible for admins' do
      page.set_rack_session(user_name: 'admin')
      visit '/shoes'
      page.find(:xpath, "//tr[2]/td[7]/form").click_button 'Виж повече'
      expect(page.find(:xpath, "//tr[1]")).to have_content "Изтрий коментара"
    end

    it 'is not visible for non-admin users' do
      page.set_rack_session(user_name: 'pesho')
      visit '/shoes'
      page.find(:xpath, "//tr[2]/td[7]/form").click_button 'Виж повече'
      expect(page.find(:xpath, "//tr[1]")).not_to have_content "Изтрий коментара"
    end

    it 'is not visible for non-users' do
      visit '/shoes'
      page.find(:xpath, "//tr[2]/td[7]/form").click_button 'Виж повече'
      expect(page.find(:xpath, "//tr[1]")).not_to have_content "Изтрий коментара"
    end

    it 'allows admin to delete comment' do
      page.set_rack_session(user_name: 'admin')
      visit '/shoes'
      page.find(:xpath, "//tr[2]/td[7]/form").click_button 'Виж повече'
      page.find(:xpath, "//tr[1]/td[3]/form").click_button 'Изтрий коментара'
      expect(page).to have_content 'Коментарът беше изтрит успешно.'
      expect(page).to have_xpath(".//tr", :count => 0)
    end
  end
end
