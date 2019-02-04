require 'rails_helper'

describe User do
  before(:each) do
    VCR.use_cassette('github_api_data') do
      current_user = create(:user)
      @user = UserPresenter.new(current_user)
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
          expect(page).to have_content("#{@user.repositories[0].name}")
          expect(page).to have_link("#{@user.repositories[0].name}")
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
    VCR.use_cassette('github_api_data') do
      current_user = create(:user)
      @user = UserPresenter.new(current_user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit '/dashboard'
    end
  end
  it 'displays followers for an authenticated user' do
    within '.github' do
      within "#followers-#{@user.followers[0].id}" do
        expect(page).to have_content(@user.followers[0].handle)
        expect(page).to have_link(@user.followers[0].handle)
      end
    end
  end
end
