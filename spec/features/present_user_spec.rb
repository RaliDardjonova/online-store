require 'spec_helper'

RSpec.describe "presenting users", type: :feature do
  describe 'access' do
    let(:admin){create :user, user_name: 'admin', admin: true}
    let(:user){create :user}
    before do
      admin.save
      user.save
    end
    it 'is visible for admins' do
      page.set_rack_session(user_name: 'admin')
      visit '/'
      expect(page).to have_content 'Потребители'
    end

    it 'is not visible for non-admin users' do
      page.set_rack_session(user_name: 'pesho')
      visit '/'
      expect(page).not_to have_content 'Потребители'
    end

    it 'is not visible for non-users' do
      visit '/'
      expect(page).not_to have_content 'Потребители'
    end

    it 'is allowed for admins' do
      page.set_rack_session(user_name: 'admin')
      visit '/'
      click_link 'Потребители'
      expect(page).to have_content 'Търси акаунти'
      expect(page).to have_content 'Акаунти'
    end

    it 'is not allowed for non-admin users' do
      page.set_rack_session(user_name: 'pesho')
      visit '/all_users'
      expect(page).to have_content 'За да достъпите тази страница трябва да имате администраторски права'
    end

    it 'is not allowed for non-users' do
      visit '/all_users'
      expect(page).to have_content 'За да достъпите тази страница трябва да имате администраторски права'
    end
  end

  describe 'search for users' do
    let(:admin){create :user, user_name: 'admin', admin: true}
    let(:user){create :user}
    let(:banned_user){create :user, user_name: 'banned_user', status: 'banned'}
    let(:banned_admin) {create :user, user_name: 'banned_admin', admin: true, status: 'banned' }
    before do
      admin.save
      user.save
      banned_user.save
      banned_admin.save
      page.set_rack_session(user_name: 'admin')
      visit '/all_users'
    end

    it 'shows all users' do
      expect(page).to have_xpath(".//tr", :count => 5)
    end

    it 'show all users if default search' do
      click_button 'Търси'
      expect(page).to have_xpath(".//tr", :count => 5)
    end

    context 'searching with user name' do
      it 'searches for user by name' do
        fill_in 'user-name-input', with: 'pesho'
        click_button 'Търси'
        expect(page).to have_xpath(".//tr", :count => 2)
        expect(page.find('//tr[2]')).to have_content 'pesho'
      end

      it 'searches for user by name and admin rights' do
        fill_in 'user-name-input', with: 'pesho'
        select "Администратор", :from => "is_admin"
        click_button 'Търси'
        expect(page).to have_content 'Няма потребители с указаните данни.'
        visit '/all_users'

        fill_in 'user-name-input', with: 'admin'
        select "Администратор", :from => "is_admin"
        click_button 'Търси'
        expect(page).to have_xpath(".//tr", :count => 2)
        expect(page.find('//tr[2]')).to have_content 'admin'
      end

      it 'searches for user by name and user rights' do
        fill_in 'user-name-input', with: 'pesho'
        select "Потребител", :from => "is_admin"
        click_button 'Търси'
        expect(page).to have_xpath(".//tr", :count => 2)
        expect(page.find('//tr[2]')).to have_content 'pesho'
        visit '/all_users'

        fill_in 'user-name-input', with: 'admin'
        select "Потребител", :from => "is_admin"
        click_button 'Търси'
        expect(page).to have_content 'Няма потребители с указаните данни.'
      end

      it 'searches for user by name and banned status' do
        fill_in 'user-name-input', with: 'pesho'
        select "Баннати", :from => "user_status"
        click_button 'Търси'
        expect(page).to have_content 'Няма потребители с указаните данни.'
        visit '/all_users'

        fill_in 'user-name-input', with: 'banned_admin'
        select "Баннати", :from => "user_status"
        click_button 'Търси'
        expect(page).to have_xpath(".//tr", :count => 2)
        expect(page.find('//tr[2]')).to have_content 'banned_admin'
      end

      it 'searches for user by name and active status' do
        fill_in 'user-name-input', with: 'pesho'
        select "Активни", :from => "user_status"
        click_button 'Търси'
        expect(page).to have_xpath(".//tr", :count => 2)
        expect(page.find('//tr[2]')).to have_content 'pesho'
        visit '/all_users'

        fill_in 'user-name-input', with: 'banned_admin'
        select "Активни", :from => "user_status"
        click_button 'Търси'
        expect(page).to have_content 'Няма потребители с указаните данни.'
      end
    end

    context 'searching without name' do
      it 'searches for active users' do
        select "Активни", :from => "user_status"
        click_button 'Търси'
        expect(page).to have_xpath(".//tr", :count => 3)
        expect(page.find('//tr[2]')).to have_content 'admin'
        expect(page.find('//tr[2]/td[5]')).not_to have_content 'Направи администратор'
        expect(page.find('//tr[2]/td[6]')).to have_content 'Спри права'
        expect(page.find('//tr[3]')).to have_content 'pesho'
        expect(page.find('//tr[3]/td[5]')).to have_content 'Направи администратор'
        expect(page.find('//tr[3]/td[6]')).to have_content 'Спри права'
      end

      it 'searches for banned users' do
        select "Баннати", :from => "user_status"
        click_button 'Търси'
        expect(page).to have_xpath(".//tr", :count => 3)
        expect(page.find('//tr[2]')).to have_content 'banned_user'
        expect(page.find('//tr[2]/td[5]')).not_to have_content 'Направи администратор'
        expect(page.find('//tr[2]/td[6]')).to have_content 'Върни права'
        expect(page.find('//tr[3]')).to have_content 'banned_admin'
        expect(page.find('//tr[3]/td[5]')).not_to have_content 'Направи администратор'
        expect(page.find('//tr[3]/td[6]')).to have_content 'Върни права'
      end

      it 'searches for admin users' do
        select "Администратор", :from => "is_admin"
        click_button 'Търси'
        expect(page).to have_xpath(".//tr", :count => 3)
        expect(page.find('//tr[2]')).to have_content 'admin'
        expect(page.find('//tr[2]/td[5]')).not_to have_content 'Направи администратор'
        expect(page.find('//tr[2]/td[6]')).to have_content 'Спри права'
        expect(page.find('//tr[3]')).to have_content 'banned_admin'
        expect(page.find('//tr[3]/td[5]')).not_to have_content 'Направи администратор'
        expect(page.find('//tr[3]/td[6]')).to have_content 'Върни права'
      end

      it 'searches for non-admin users' do
        select "Потребител", :from => "is_admin"
        click_button 'Търси'
        expect(page).to have_xpath(".//tr", :count => 3)
        expect(page.find('//tr[2]')).to have_content 'pesho'
        expect(page.find('//tr[2]/td[5]')).to have_content 'Направи администратор'
        expect(page.find('//tr[2]/td[6]')).to have_content 'Спри права'
        expect(page.find('//tr[3]')).to have_content 'banned_user'
        expect(page.find('//tr[3]/td[5]')).not_to have_content 'Направи администратор'
        expect(page.find('//tr[3]/td[6]')).to have_content 'Върни права'
      end

      it 'searches for active admin users' do
        select "Активни", :from => "user_status"
        select "Администратор", :from => "is_admin"
        click_button 'Търси'
        expect(page).to have_xpath(".//tr", :count => 2)
        expect(page.find('//tr[2]')).to have_content 'admin'
        expect(page.find('//tr[2]/td[5]')).not_to have_content 'Направи администратор'
        expect(page.find('//tr[2]/td[6]')).to have_content 'Спри права'
      end

      it 'searces for bannes admin users' do
        select "Баннати", :from => "user_status"
        select "Администратор", :from => "is_admin"
        click_button 'Търси'
        expect(page).to have_xpath(".//tr", :count => 2)
        expect(page.find('//tr[2]')).to have_content 'banned_admin'
        expect(page.find('//tr[2]/td[5]')).not_to have_content 'Направи администратор'
        expect(page.find('//tr[2]/td[6]')).to have_content 'Върни права'
      end

      it 'searces for active non-admin users' do
        select "Активни", :from => "user_status"
        select "Потребител", :from => "is_admin"
        click_button 'Търси'
        expect(page).to have_xpath(".//tr", :count => 2)
        expect(page.find('//tr[2]')).to have_content 'pesho'
        expect(page.find('//tr[2]/td[5]')).to have_content 'Направи администратор'
        expect(page.find('//tr[2]/td[6]')).to have_content 'Спри права'
      end

      it 'searces for banned non-admin users' do
        select "Баннати", :from => "user_status"
        select "Потребител", :from => "is_admin"
        click_button 'Търси'
        expect(page).to have_xpath(".//tr", :count => 2)
        expect(page.find('//tr[2]')).to have_content 'banned_user'
        expect(page.find('//tr[2]/td[5]')).not_to have_content 'Направи администратор'
        expect(page.find('//tr[2]/td[6]')).to have_content 'Върни права'
      end
    end
  end

  describe 'change user data' do
    let(:admin){create :user, user_name: 'admin', admin: true}
    let(:admin2){create :user, user_name: 'admin2', admin: true}
    let(:user){create :user}
    let(:banned_user){create :user, user_name: 'banned_user', status: 'banned'}
    let(:banned_admin) {create :user, user_name: 'banned_admin', admin: true, status: 'banned' }
    before do
      admin.save
      admin2.save
      user.save
      banned_user.save
      banned_admin.save
      page.set_rack_session(user_name: 'admin')
      visit '/all_users'
    end

    it 'can ban user' do
      page.find(:xpath, "//tr[3]/td[6]/form").click_button 'Спри права'
      expect(page).to have_content 'Потребителят беше баннат успешно.'
      expect(User.find(2).status).to eq('banned')
    end

    it 'can activate user' do
      page.find(:xpath, "//tr[6]/td[6]/form").click_button 'Върни права'
      expect(page).to have_content 'Правата за достъп на потребителя бяха възстановени успешно.'
      expect(User.find(5).status).to eq('active')
    end

    it 'can change user to be admin' do
      page.find(:xpath, "//tr[4]/td[5]/form").click_button 'Направи администратор'
      expect(page).to have_content 'Потрбителят беше успешно повишен до ниво Администратор.'
      expect(User.find(3).admin).to eq(true)
    end
  end
end
