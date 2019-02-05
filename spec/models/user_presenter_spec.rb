require 'rails_helper'

RSpec.describe UserPresenter, type: :model do
  describe 'information' do
    before(:each) do
      VCR.use_cassette('github_api_data') do
        current_user = create(:user, first_name: 'john', last_name: 'smith', email: 'js@gmail.com')
        @user = UserPresenter.new(current_user)
      end
    end

    it 'has the relevant attributes a standard user has' do
      expect(@user.first_name).to eq("john")
      expect(@user.last_name).to eq("smith")
      expect(@user.email).to eq("js@gmail.com")
      expect(@user.token).to eq("#{ENV['GIT_HUB_PLACEHOLDER_KEY']}")
    end

    it 'has all of the user repositories' do
      expect(@user.repositories).to be_a(Array)
    end

    it 'has all of the followers for this user' do
      expect(@user.followers).to be_a(Array)
    end

    it 'has a list of github profiles user is following' do
      expect(@user.following).to be_a(Array)
    end
  end
end
