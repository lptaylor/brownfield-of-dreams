require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:password)}
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name:'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end

  describe 'instance methods' do
    it 'starts with no friends' do
      user = create(:user)

      expect(user.friends.count).to eq(0)
    end

    it 'add_friend' do
      user = create(:user)
      user_2 = create(:user, uid: 111, email: 'tim@gmail.com')

      user.add_friend(user_2.uid)

      expect(user.friends[0].email).to eq(user_2.email)
    end

    it 'already_friends?' do
      user = create(:user)
      user_2 = create(:user, uid: 111, email: 'tim@gmail.com')

      user.add_friend(user_2.uid)

      expect(user.already_friends?(user_2.uid)).to be true
    end
  end
end
