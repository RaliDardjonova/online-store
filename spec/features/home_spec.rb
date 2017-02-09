require 'spec_helper'

RSpec.describe "home_page", type: :feature do
  describe 'home page' do
    before { visit '/'}
    it 'shows welcoming message' do
      visit '/'
      expect(page).to have_content 'Добре дошли'
    end
  end
end
