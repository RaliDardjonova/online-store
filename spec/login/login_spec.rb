require 'spec_helper'

RSpec.describe "home_page", type: :login do
  describe 'home page' do
    before { visit '/'}
    it 'shows welcoming sth' do
      visit '/'
      expect(page).to have_content 'Добре дошли'
    end

    

  end
end
