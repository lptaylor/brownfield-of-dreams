require 'rails_helper'

describe User do
  before(:each) do
    VCR.use_cassette('friends') do
      @current_user = create(:user)
      @user_1 = create(:user, uid: 42525195, github_username: 'johnnytsunami')
      @user = UserPresenter.new(@current_user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit '/dashboard'
    end
  end
  it 'shows a section for friends' do
    expect(page).to have_content('Friends List')
  end

  it 'shows friends in section' do
    within '.github' do
      within "#github_followers-#{@user.github_followers[0].id}" do
        click_on 'Follow This User'
      end
    end

    within '.friends' do
      expect(page).to have_content(@user_1.github_username)
    end
  end

end
