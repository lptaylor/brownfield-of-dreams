require 'rails_helper'

describe User do
  before(:each) do
    @user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit '/dashboard'

  end
  it 'shows a section for Github' do
    within '.github' do
      expect(page).to have_content('Github')

    end
  end
end
# As a logged in user
# When I visit /dashboard
# Then I should see a section for "Github"
# And under that section I should see a list
# of 5 repositories with the name of each Repo linking to the repo on Github
