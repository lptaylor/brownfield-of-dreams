require 'rails_helper'

describe 'as a user' do
  before(:each) do
    VCR.use_cassette('mock_auth') do
      current_user = create(:user, token: nil)
      @user_1 = UserPresenter.new(current_user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
      visit dashboard_path
      OmniAuth.config.mock_auth[:github] = nil
    end
  end
  it 'shows button to connect to github' do
    expect(page).to have_button('Sign in with GitHub')
  end
  it 'returns user to dash and updates user with github token' do
    stub_omniauth_github
    expect(@user_1.token).to eq(nil)
    VCR.use_cassette('nonsense') do
      click_button 'Sign in with GitHub'
      expect(@user_1.token).to eq('dfafeaf3432q45432454')
      expect(current_path).to be(dashboard_path)
    end
  end
  it 'returns user to dash and updates user with github uid' do
    stub_omniauth_github
    expect(@user_1.uid).to eq(nil)
    VCR.use_cassette('nonsense') do
      click_button 'Sign in with GitHub'
      expect(@user_1.uid).to eq(123545)
      expect(current_path).to be(dashboard_path)
    end
  end
end
