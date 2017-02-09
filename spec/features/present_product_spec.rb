require 'spec_helper'

RSpec.describe "presenting products", type: :feature do
  describe 'table of shoes' do
    let(:shoes1) {create :shoe}
    let(:shoes2) {create :shoe, product_name: 'nike', product_id: 2, description: "Описание на обувки nike."}
    before do
      shoes1.save
      shoes2.save
      visit '/shoes'
    end

    it 'shows all shoes' do
      expect(page).to have_xpath(".//tr", :count => 3)
    end

    it 'presents information for shoes correctly' do
      expect(page.find(:xpath, "//tr[2]/td[1]")).to have_content 'adidas'
      expect(page.find(:xpath, "//tr[2]/td[2]")).to have_content 'Спортни'
      expect(page.find(:xpath, "//tr[2]/td[3]")).to have_content 'Мъжки'
      expect(page.find(:xpath, "//tr[2]/td[4]")).to have_content 'Бял'
      expect(page.find(:xpath, "//tr[2]/td[5]")).to have_content '40.0-48.0'
      expect(page.find(:xpath, "//tr[2]/td[6]")).to have_content '60.0лв'
      expect(page.find(:xpath, "//tr[2]/td[7]")).to have_content 'Виж повече'
    end

    it 'opens specific page for every shoes' do
      page.find(:xpath, "//tr[2]/td[7]/form").click_button 'Виж повече'
      expect(page).to have_content "#{shoes1.description}"
      visit '/shoes'
      page.find(:xpath, "//tr[3]/td[7]/form").click_button 'Виж повече'
      expect(page).to have_content "#{shoes2.description}"
    end
  end

  describe 'table of tops' do
    let(:top1) {create :top}
    let(:top2) {create :top, product_name: 'mango', product_id: 2, description: "Описание на mango."}
    before do
      top1.save
      top2.save
      visit '/tops'
    end

    it 'shows all tops' do
      expect(page).to have_xpath(".//tr", :count => 3)
    end

    it 'presents information for tops correctly' do
      expect(page.find(:xpath, "//tr[2]/td[1]")).to have_content 'bluza'
      expect(page.find(:xpath, "//tr[2]/td[2]")).to have_content 'Ризи'
      expect(page.find(:xpath, "//tr[2]/td[3]")).to have_content 'Дамски'
      expect(page.find(:xpath, "//tr[2]/td[4]")).to have_content 'Бял'
      expect(page.find(:xpath, "//tr[2]/td[5]")).to have_content 'S-XL'
      expect(page.find(:xpath, "//tr[2]/td[6]")).to have_content '15.0лв'
      expect(page.find(:xpath, "//tr[2]/td[7]")).to have_content 'Виж повече'
    end

    it 'opens specific page for every top' do
      page.find(:xpath, "//tr[2]/td[7]/form").click_button 'Виж повече'
      expect(page).to have_content "#{top1.description}"
      visit '/tops'
      page.find(:xpath, "//tr[3]/td[7]/form").click_button 'Виж повече'
      expect(page).to have_content "#{top2.description}"
    end
  end

  describe 'table of trousers' do
    let(:trouser1) {create :trouser}
    let(:trouser2) {create :trouser, product_name: 'dynki', product_id: 2, description: "Описание на dynki"}
    before do
      trouser1.save
      trouser2.save
      visit '/trousers'
    end

    it 'shows all trousers' do
      expect(page).to have_xpath(".//tr", :count => 3)
    end

    it 'presents information for trousers correctly' do
      expect(page.find(:xpath, "//tr[2]/td[1]")).to have_content 'pantaloni'
      expect(page.find(:xpath, "//tr[2]/td[2]")).to have_content 'Къси - дънки'
      expect(page.find(:xpath, "//tr[2]/td[3]")).to have_content 'Унисекс'
      expect(page.find(:xpath, "//tr[2]/td[4]")).to have_content 'Зелен'
      expect(page.find(:xpath, "//tr[2]/td[5]")).to have_content '25.0-32.0'
      expect(page.find(:xpath, "//tr[2]/td[6]")).to have_content '35.0лв'
      expect(page.find(:xpath, "//tr[2]/td[7]")).to have_content 'Виж повече'
    end

    it 'opens specific page for every trouser' do
      page.find(:xpath, "//tr[2]/td[7]/form").click_button 'Виж повече'
      expect(page).to have_content "#{trouser1.description}"
      visit '/trousers'
      page.find(:xpath, "//tr[3]/td[7]/form").click_button 'Виж повече'
      expect(page).to have_content "#{trouser2.description}"
    end
  end

  describe 'availability' do
    let(:shoes1) {create :shoe}
    let(:shoes2) {create :shoe, product_name: 'nike', product_id: 2, description: "Описание на обувки nike.", amount: 0}
    before do
      shoes1.save
      shoes2.save
      visit '/shoes'
    end
    it 'shows when product is available' do
      page.find(:xpath, "//tr[2]/td[7]/form").click_button 'Виж повече'
      expect(page).to have_content "В наличност"
    end

    it 'shows when product is not available' do
      page.find(:xpath, "//tr[3]/td[7]/form").click_button 'Виж повече'
      expect(page).to have_content "Продуктът е изчерпан"
    end
  end

  describe 'searching for product' do
    let(:shoes) {create :shoe}
    let(:top) {create :top, product_id: 2}
    let(:trouser) {create :trouser, product_id: 3}

    before do
      shoes.save
      top.save
      trouser.save
      visit '/search'
    end

    it 'shows all products' do
      expect(page).to have_xpath(".//tr", :count => 4)
    end

    it 'opens the specific page of every product' do
      page.find(:xpath, "//tr[2]/td[7]/form").click_button 'Виж повече'
      expect(page).to have_content "#{shoes.description}"
      visit '/search'
      page.find(:xpath, "//tr[3]/td[7]/form").click_button 'Виж повече'
      expect(page).to have_content "#{top.description}"
      visit '/search'
      page.find(:xpath, "//tr[4]/td[7]/form").click_button 'Виж повече'
      expect(page).to have_content "#{trouser.description}"
    end

    it 'presents information for products correctly' do
      expect(page.find(:xpath, "//tr[3]/td[1]")).to have_content 'bluza'
      expect(page.find(:xpath, "//tr[3]/td[2]")).to have_content 'Ризи'
      expect(page.find(:xpath, "//tr[3]/td[3]")).to have_content 'Дамски'
      expect(page.find(:xpath, "//tr[3]/td[4]")).to have_content 'Бял'
      expect(page.find(:xpath, "//tr[3]/td[5]")).to have_content 'S-XL'
      expect(page.find(:xpath, "//tr[3]/td[6]")).to have_content '15.0лв'
      expect(page.find(:xpath, "//tr[3]/td[7]")).to have_content 'Виж повече'
    end

    it 'shows only specific type when selecting type' do

      select "Обувки", :from => "type"
      click_button 'Търси'
      expect(current_path).to have_content('select_products')

      expect(page).to have_xpath(".//tr", :count => 2)
    end

    it 'searches by color' do
      page.choose("color-input", option: 'white')
      click_button 'Търси'
      expect(page.find(:xpath, "//tr[2]/td[1]")).to have_content 'adidas'
        expect(page.find(:xpath, "//tr[3]/td[1]")).to have_content 'bluza'
      expect(page).to have_xpath(".//tr", :count => 3)
    end

    it 'searches by category that can be found in db' do
      select "Обувки", :from => "type"
      click_button 'Търси'
      page.choose("category-input", option: 'sport')
      click_button 'Търси'
      expect(page).to have_xpath(".//tr", :count => 2)
      expect(page.find(:xpath, "//tr[2]/td[1]")).to have_content 'adidas'
    end

    it 'searches by category that can\'t be found in db' do
      select "Обувки", :from => "type"
      click_button 'Търси'
      page.choose("category-input", option: 'formal')
      click_button 'Търси'
      expect(page).to have_xpath(".//tr", :count => 0)
    end

    it 'searches by size' do
      select "Панталони", :from => "type"
      click_button 'Търси'
      page.fill_in("size-input", with: '26')
      click_button 'Търси'
      expect(page).to have_xpath(".//tr", :count => 2)
      expect(page.find(:xpath, "//tr[2]/td[1]")).to have_content 'pantaloni'
    end

    it 'searches by gender' do
      page.choose("gender-input", option: 'unisex')
      click_button 'Търси'
      expect(page).to have_xpath(".//tr", :count => 2)
      expect(page.find(:xpath, "//tr[2]/td[1]")).to have_content 'pantaloni'
    end

    it 'searches by price' do
      page.choose("price-input", option: '1')
      click_button 'Търси'
      expect(page).to have_xpath(".//tr", :count => 3)
      expect(page.find(:xpath, "//tr[2]/td[1]")).to have_content 'bluza'
      expect(page.find(:xpath, "//tr[3]/td[1]")).to have_content 'pantaloni'
    end
  end
end
