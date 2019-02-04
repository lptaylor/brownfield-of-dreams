require 'rails_helper'

describe 'as a user' do
  before(:each) do
    VCR.use_cassette('follower_data') do
      current_user = create(:user, token: ENV['GIT_HUB_PLACEHOLDER_KEY'])
      @user_1 = UserPresenter.new(current_user)
      @user_2 = create(:user, token: ENV['GIT_HUB_PLACEHOLDER_KEY_2'])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
      visit dashboard_path
    end
  end
  it 'shows a link to follow another user' do
    within '.github' do
      within "#followers-#{@user_1.followers[4].id}" do
        expect(page).to have_link("Follow This User")
      end
    end
  end
end
