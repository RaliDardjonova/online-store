require 'spec_helper'

RSpec.describe "creating and login with user", type: :feature do
  describe 'registration' do
    before { visit '/create_user'}

    it 'shows registration message' do
      expect(page).to have_content 'Регистрация'
    end

    it 'can create new user' do
      within 'form' do
        fill_in 'user_name', with: 'tisho'
        fill_in 'e-mail', with: 'tisho@abv.bg'
        fill_in 'password', with: 'tisho',  visible: false
      end

      click_button 'Регистрирай се!'
      expect(User.find_by user_name: 'tisho').not_to eq(nil)
      expect(page).to have_content 'Поздравления! Вашият акаунт вече е активиран.'
    end

    it 'prevents registration if user name exists' do
      user = create :user
      within 'form' do
        fill_in 'user_name', with: 'pesho'
        fill_in 'e-mail', with: 'pesho@abv.bg'
        fill_in 'password', with: 'pesho',  visible: false
      end
      click_button 'Регистрирай се!'

      expect(page).to have_content 'Потребител с това име вече съществува.'

    end

    it 'catches invalid short password' do
      user = create :user
      within 'form' do
        fill_in 'user_name', with: 'pesho'
        fill_in 'e-mail', with: 'pesho@abv.bg'
        fill_in 'password', with: 'pes',  visible: false
      end
      click_button 'Регистрирай се!'
      expect(page).to have_content 'Грешка!Паролата трябва да съдържа минимум 4 знака.'
    end

    it 'catches invalid characters password' do
      user = create :user
      within 'form' do
        fill_in 'user_name', with: 'pesho'
        fill_in 'e-mail', with: 'pesho@abv.bg'
        fill_in 'password', with: 'pesП*ъ',  visible: false
      end
      click_button 'Регистрирай се!'
      expect(page).to have_content "Грешка!Паролата може да съдържа'\
                  ' само латински букви, цифри и _."
    end

    it 'catches invalid user name' do
      user = create :user
      within 'form' do
        fill_in 'user_name', with: 'peshoД'
        fill_in 'e-mail', with: 'pesho@abv.bg'
        fill_in 'password', with: 'pesho',  visible: false
      end
      click_button 'Регистрирай се!'
      expect(page).to have_content "Неподхощи данни. #{user.errors.full_messages.to_sentence}"
    end

    it 'catches invalid e-mail' do
      user = create :user
      within 'form' do
        fill_in 'user_name', with: 'pesho'
        fill_in 'e-mail', with: 'peshoabv.bg'
        fill_in 'password', with: 'pesho',  visible: false
      end
      click_button 'Регистрирай се!'
      expect(page).to have_content "Неподхощи данни. #{user.errors.full_messages.to_sentence}"
    end
  end

  describe 'login' do

    let(:user1) {create :user}
    let(:user2) {create :user, user_name: 'admin', admin: true}
    let(:user3) {create :user, user_name: 'banned', status: 'banned'}
    before do
      user1.save
      user2.save
      user3.save
      visit '/login'
    end

    it 'logins as user with correct data' do
      within 'form' do
        fill_in 'user_name', with: 'pesho'
        fill_in 'password', with: 'pesho123',  visible: false
      end
      click_button 'Вход'

      expect(page).to have_content "Влезли сте като: pesho"
      expect(page).to have_content "Поздравления! Успешно влизане."
      expect(page.get_rack_session_key('user_name')).to eq('pesho')
    end

    it 'logins as admin with correct data' do

      within 'form' do
        fill_in 'user_name', with: 'admin'
        fill_in 'password', with: 'pesho123',  visible: false
      end
      click_button 'Вход'

      expect(page).to have_content "Влезли сте като: admin (Администратор)"
      expect(page).to have_content "Поздравления! Успешно влизане."
      expect(page.get_rack_session_key('user_name')).to eq('admin')
    end

    it 'prevents login with incorrect data' do
      within 'form' do
        fill_in 'user_name', with: 'pesho'
        fill_in 'password', with: 'pesho12',  visible: false
      end
      click_button 'Вход'

      expect(page).not_to have_content "Влезли сте като: pesho"
      expect(page).to have_content "Грешни име или парола."
      expect(page.get_rack_session['user_name']).to eq(nil)
    end

    it 'prevents login as banned user' do
      within 'form' do
        fill_in 'user_name', with: 'banned'
        fill_in 'password', with: 'pesho123',  visible: false
      end
      click_button 'Вход'

      expect(page).not_to have_content "Влезли сте като: banned"
      expect(page).to have_content "Вашите права са отнети. ' \
                  'Не можете да влезнете в момента!"
      expect(page.get_rack_session['user_name']).to eq(nil)
    end

  end
end
