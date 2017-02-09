require 'spec_helper'

RSpec.describe User do
  describe 'create user' do

    it 'passes valid user' do
      user = build :user, user_name: "pesho", email: "pesho@abv.bg"
      expect(user).to be_valid

      user = build :user, user_name: "pablo_23", email: "pablo_23@abv.bg"
      expect(user).to be_valid
    end

    it 'catches not valid email' do
      user = build :user, email: "peshoabv.bg"
      expect(user).not_to be_valid

      user = build :user, email: "@abv.bg"
      expect(user).not_to be_valid

      user = build :user, email: "pesho@abvbg"
      expect(user).not_to be_valid
    end

    it 'catches not valid user name' do
      user = build :user, email: "pesh*6"
      expect(user).not_to be_valid

      user = build :user, email: "пешо2"
      expect(user).not_to be_valid

      user = build :user, email: "pe"
      expect(user).not_to be_valid

      user = build :user, email: "pesho_pesho_pesho_pesho"
      expect(user).not_to be_valid
    end
  end

  describe 'authentication' do
    let(:salt) { "$2a$10$.WILeBRVX8FLg4cGIK4pTu"}
    let(:password_hash) {"$2a$10$.WILeBRVX8FLg4cGIK4pTu5p4Qp3Ux8lhYFawaEi8TdO1vwuh/wKq"}
    let(:user1) {FactoryGirl.create :user}
    let(:user2) {FactoryGirl.create :user, user_name: 'kolyo', salt: salt, password_hash: password_hash}

    before do
      user1.save
      user2.save
    end

    it 'authenticates correct user correctly' do
      expect(User.authenticate('pesho', 'pesho123')).to eq(user1)
      expect(User.authenticate('kolyo', "12kolyo_23")).to eq(user2)
    end

    it 'authenticates incorrect user correctly' do
      expect(User.authenticate('pesho', 'pesho12')).to eq(nil)
      expect(User.authenticate('kolyo', 'kolyo_23')).to eq(nil)
    end
  end

  
end
