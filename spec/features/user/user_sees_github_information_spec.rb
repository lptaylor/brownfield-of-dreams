require 'rails_helper'

describe User do
  before(:each) do
    VCR.use_cassette('repository_data') do
      @user = create(:user)
      followers_data = FollowerListFacade.new(@user)
      @followers = followers_data.user_followers_list
      repo_list = RepositoryListResultFacade.new(@user)
      @repositories = repo_list.user_repository_list
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
      all('.repository').first do
          expect(page).to have_content("#{@repositories[0].name}")
          expect(page).to have_link("#{@repositories[0].name}")
      end
    end
  end
end

describe 'non token or no repos' do
  xit 'shows message if repositories list is 0' do

  end
end

describe 'followers' do
  before(:each) do
    VCR.use_cassette('follower_data') do
      @user = create(:user)
      repo_list = RepositoryListResultFacade.new(@user)
      @repositories = repo_list.user_repository_list
      followers_data = FollowerListFacade.new(@user)
      @followers = followers_data.user_followers_list
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit '/dashboard'
    end
  end
  it 'displays followers for an authenticated user' do
    within '.github' do
      within "#followers-#{@followers[0].id}" do
        expect(page).to have_content(@followers[0].handle)
        expect(page).to have_link(@followers[0].handle)
      end
    end
  end
end
