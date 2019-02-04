require 'rails_helper'

describe 'as a user' do
  before(:each) do
    VCR.use_cassette('oauth_data') do
      current_user = create(:user, token: nil)
      @user_1 = UserPresenter.new(current_user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
      visit dashboard_path
    end
  end
  it 'shows button to connect to github' do
      expect(page).to have_button('Sign in with GitHub')
  end
end
