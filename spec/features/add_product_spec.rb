require 'spec_helper'

RSpec.describe "adding products", type: :feature do
  describe 'access' do
    before{visit '/add_product'}
    it 'allows admins to enter' do
      admin = create :user, admin: true
      admin.save
      page.set_rack_session(user_name: 'pesho')
      visit '/add_product'
      expect(page).to have_content 'Добавяне на продукти'
    end

    it 'does not allow non-admin users to enter' do
      admin = create :user
      admin.save
      page.set_rack_session(user_name: 'pesho')
      visit '/add_product'
      expect(page).to have_content 'За да достъпите тази страница трябва да имате администраторски права'
    end


    it 'does not allow non-users to enter' do
      expect(page).to have_content 'За да достъпите тази страница трябва да имате администраторски права'
    end
  end

  describe 'goes to custom pages for adding products' do
    let(:admin){create :user, admin: true}
    before do
      admin.save
      page.set_rack_session(user_name: 'pesho')
      visit '/add_product'
    end
    it 'goes to the correct page for adding shoes' do
      select "Обувки", :from => "type"
      click_button 'type-submit'
      expect(page).to have_content 'Добавяне на обувки'
    end

    it 'goes to the correct page for adding tops' do
      select "Блузи", :from => "type"
      click_button 'type-submit'
      expect(page).to have_content 'Добавяне на блузи'
    end

    it 'goes to the correct page for adding tops' do
      select "Панталони", :from => "type"
      click_button 'type-submit'
      expect(page).to have_content 'Добавяне на панталони'
    end
  end

  describe 'adding products' do
    let(:admin){create :user, admin: true}
    before do
      admin.save
      page.set_rack_session(user_name: 'pesho')
      visit '/add_product'
    end

    it 'successfully add shoes' do
      select "Обувки", :from => "type"
      click_button 'type-submit'

      within "form[id='add-product']" do
        fill_in 'product-name-input', with: 'nike'
        fill_in 'description-input', with: 'Описание на nike'
        fill_in 'price-input', with: 75
        fill_in 'size-input-min', with: 36
        fill_in 'size-input-max', with: 42
        page.choose("color-input", option: 'purple')
        page.choose("gender-input", option: 'women')
        page.choose("category-input", option: 'formal')
        fill_in 'amount-input', with: 30
      end
      click_button 'Запиши'

      expect(page).to have_content 'Добавянето на продукта беше успешно.'
    end

    it 'successfully add tops' do
      select "Блузи", :from => "type"
      click_button 'type-submit'

      within "form[id='add-product']" do
        fill_in 'product-name-input', with: 'mango'
        fill_in 'description-input', with: 'Описание на mango'
        fill_in 'price-input', with: 25
        page.choose("size-input-min", option: '1')
        page.choose("size-input-max", option: '5')
        page.choose("color-input", option: 'black')
        page.choose("gender-input", option: 'men')
        page.choose("category-input", option: 'shirt')
        fill_in 'amount-input', with: 40
      end
      click_button 'Запиши'

      expect(page).to have_content 'Добавянето на продукта беше успешно.'
    end

    it 'successfully add trousers' do
      select "Панталони", :from => "type"
      click_button 'type-submit'

      within "form[id='add-product']" do
        fill_in 'product-name-input', with: 'dynki'
        fill_in 'description-input', with: 'Описание на dynki'
        fill_in 'price-input', with: 45
        fill_in 'size-input-min', with: 26
        fill_in 'size-input-max', with: 32
        page.choose("color-input", option: 'blue')
        page.choose("gender-input", option: 'unisex')
        page.choose("category-input", option: 'long-jeans')
        fill_in 'amount-input', with: 60
      end
      click_button 'Запиши'

      expect(page).to have_content 'Добавянето на продукта беше успешно.'
    end

    it 'prevents adding shoes when min size > max size' do
      select "Обувки", :from => "type"
      click_button 'type-submit'

      within "form[id='add-product']" do
        fill_in 'product-name-input', with: 'nike'
        fill_in 'description-input', with: 'Описание на nike'
        fill_in 'price-input', with: 75
        fill_in 'size-input-min', with: 43
        fill_in 'size-input-max', with: 42
        page.choose("color-input", option: 'purple')
        page.choose("gender-input", option: 'women')
        page.choose("category-input", option: 'formal')
        fill_in 'amount-input', with: 30
      end
      click_button 'Запиши'

      expect(page).to have_content 'Грешка. Минималният размер е по-голям от максималния!'
    end

    it 'prevents adding tops when min size > max size' do
      select "Блузи", :from => "type"
      click_button 'type-submit'

      within "form[id='add-product']" do
        fill_in 'product-name-input', with: 'mango'
        fill_in 'description-input', with: 'Описание на mango'
        fill_in 'price-input', with: 25
        page.choose("size-input-min", option: '4')
        page.choose("size-input-max", option: '1')
        page.choose("color-input", option: 'black')
        page.choose("gender-input", option: 'men')
        page.choose("category-input", option: 'shirt')
        fill_in 'amount-input', with: 40
      end
      click_button 'Запиши'

      expect(page).to have_content 'Грешка. Минималният размер е по-голям от максималния!'
    end

    it 'prevents adding trousers when min size > max size' do
      select "Панталони", :from => "type"
      click_button 'type-submit'

      within "form[id='add-product']" do
        fill_in 'product-name-input', with: 'dynki'
        fill_in 'description-input', with: 'Описание на dynki'
        fill_in 'price-input', with: 45
        fill_in 'size-input-min', with: 26
        fill_in 'size-input-max', with: 22
        page.choose("color-input", option: 'blue')
        page.choose("gender-input", option: 'unisex')
        page.choose("category-input", option: 'long-jeans')
        fill_in 'amount-input', with: 60
      end
      click_button 'Запиши'

      expect(page).to have_content 'Грешка. Минималният размер е по-голям от максималния!'
    end
  end
end
