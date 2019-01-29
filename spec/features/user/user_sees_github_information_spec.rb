require 'rails_helper'

describe User do
  before(:each) do
    VCR.use_cassette('repository_data') do
      @user = create(:user)
      @repositories = RepositoryListResult.user_repository_list
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit '/dashboard'
    end
  end
  it 'shows a section for Github' do
    within '.github' do
      expect(page).to have_content('Github')
    end
  end

  it 'lists 5 repositories with each name being a link to that repository' do
    within '.github' do
      within "#repository-#{@repositories[0].id}" do
        expect(page).to have_content("#{@repositories[0].name}")
        expect(page).to have_link("#{@repositories[0].name}")
      end
    end
  end


end
# As a logged in user
# When I visit /dashboard
# Then I should see a section for "Github"
# And under that section I should see a list
# of 5 repositories with the name of each Repo linking to the repo on Github
