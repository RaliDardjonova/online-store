require 'spec_helper'

RSpec.describe User do
  describe 'create user' do
    before { visit '/create_user'}

    it 'passes valid user' do
      user = create :user, user_name: "pesho", email: "pesho@abv.bg", admin: false, status: 'active'
      expect(user).to be_valid
    end

    it 'catches not valid email' do
    user = build :user, email: "peshoabv.bg"
    expect(user).not_to be_valid
    end

    it 'catches not valid user name' do
    user = build :user, email: "pesh*6"
    expect(user).not_to be_valid
    end

  end
end
