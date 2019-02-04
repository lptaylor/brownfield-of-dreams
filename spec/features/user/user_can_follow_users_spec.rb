require 'rails_helper'

describe 'as a user' do
  before(:each) do
    VCR.use_cassette('follower_data') do
      current_user = create(:user, token: ENV['GIT_HUB_PLACEHOLDER_KEY'])
      @user_1 = UserPresenter.new(current_user)
      @user_2 = create(:user, token: ENV['GIT_HUB_PLACEHOLDER_KEY_2'], uid: 134434)
      @user_3 = create(:user, token: ENV['GIT_HUB_PLACEHOLDER_KEY_2'])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
      visit dashboard_path
    end
  end
  it 'shows a link to follow another user who is following user' do
    within '.github' do
      within "#followers-#{@user_1.followers[4].uid}" do
        expect(page).to have_link("Follow This User")
      end
    end
  end
  it 'shows a link to follow another user who user is following' do
    within '.github' do
      within "#following-#{@user_1.following[1].uid}" do
        expect(page).to have_link("Follow This User")
      end
    end
  end
  it 'will not show link if user is not a registered user in the app' do
    within '.github' do
      within "#following-#{@user_1.following[0].uid}" do
        expect(page).to_not have_link("Follow This User")
      end
    end
    within '.github' do
      within "#followers-#{@user_1.followers[1].uid}" do
        expect(page).to_not have_link("Follow This User")
      end
    end
  end
end
