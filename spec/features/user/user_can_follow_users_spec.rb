require 'rails_helper'

describe 'as a user' do
  before(:each) do
    current_user = create(:user, token: ENV['GIT_HUB_PLACEHOLDER_KEY'])
    @user_1 = UserPresenter.new(current_user)
    @user_2 = create(:user, token: ENV['GIT_HUB_PLACEHOLDER_KEY_2'], uid: 35861146)
    @user_3 = create(:user, token: ENV['GIT_HUB_PLACEHOLDER_KEY_2'], uid: 42525195)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
    visit dashboard_path
  end

  it 'shows a link to follow another user who is github_following user' do
    within '.github' do
      within "#github_followers-#{@user_1.github_followers[4].id}" do
        expect(page).to have_button("Follow This User")
      end
    end
  end

  it 'shows a link to follow another user who user is github_following' do
    within '.github' do
      within "#github_following-#{@user_1.github_following[1].id}" do
        expect(page).to have_button("Follow This User")
      end
    end
  end

  it 'will not show link if user is not a registered user in the app' do
    within '.github' do
      within "#github_followers-#{@user_1.github_followers[1].id}" do
        expect(page).to_not have_link("Follow This User")
      end
    end
    within '.github' do
      within "#github_following-#{@user_1.github_following[0].id}" do
        expect(page).to_not have_link("Follow This User")
      end
    end
  end

  it 'forms follower relationship when clicked on' do
    within '.github' do
      within "#github_following-#{@user_1.github_following[1].id}" do
        click_button("Follow This User")

        expect(current_path).to eq(dashboard_path)

      end
    end
    expect(page).to have_content("You are now Friends!")
  end

  xdescribe 'invalid user ' do
    it 'returns an error message when invalid user' do
      current_user = create(:user, token: ENV['GIT_HUB_PLACEHOLDER_KEY'])
      user_1 = UserPresenter.new(current_user)
      user_2 = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
      visit dashboard_path

      within '.github' do
        within "#github_following-#{user_1.github_following[1].id}" do
          click_button("Follow This User")
          expect(current_path).to eq(dashboard_path)
          save_and_open_page
        end
      end
      expect(page).to have_content("Not a Valid User")
    end
  end
end
