require 'rails_helper'

describe 'vister can create an account', :js do
  it ' visits the home page' do
    VCR.use_cassette('github_api_data') do
      email = 'jimbob@aol.com'
      first_name = 'Jim'
      last_name = 'Bob'
      password = 'password'
      password_confirmation = 'password'

      visit '/'

      click_on 'Sign In'

      expect(current_path).to eq(login_path)

      click_on 'Sign up now.'

      expect(current_path).to eq(register_path)

      fill_in 'user[email]', with: email
      fill_in 'user[first_name]', with: first_name
      fill_in 'user[last_name]', with: last_name
      fill_in 'user[password]', with: password
      fill_in 'user[password_confirmation]', with: password

      click_on'Create Account'

      expect(current_path).to eq(dashboard_path)

      expect(page).to have_content(email)
      expect(page).to have_content(first_name)
      expect(page).to have_content(last_name)
      expect(page).to_not have_content('Sign In')
    end
  end

  it 'it sends an email when registering' do
    VCR.use_cassette('github_api_data') do
      email = 'jimbob@aol.com'
      first_name = 'Jim'
      last_name = 'Bob'
      password = 'password'
      password_confirmation = 'password'

      visit '/'

      click_on 'Sign In'

      expect(current_path).to eq(login_path)

      click_on 'Sign up now.'

      expect(current_path).to eq(register_path)

      fill_in 'user[email]', with: email
      fill_in 'user[first_name]', with: first_name
      fill_in 'user[last_name]', with: last_name
      fill_in 'user[password]', with: password
      fill_in 'user[password_confirmation]', with: password

      click_on'Create Account'

      expect(current_path).to eq(dashboard_path)

      open_email(email)
      expect(current_email).to have_content("Please click below ")
      expect(page).to have_content(email)
      expect(page).to have_content(first_name)
      expect(page).to have_content(last_name)
      expect(page).to_not have_content('Sign In')
    end
  end
  describe 'sad path user regestration' do
    it 'cannot register with existing user email' do
      create(:user, email: 'timmy@gmail.com')
      email = 'timmy@gmail.com'
      first_name = 'Jim'
      last_name = 'Bob'
      password = 'password'

      visit register_path
      fill_in 'user[email]', with: email
      fill_in 'user[first_name]', with: first_name
      fill_in 'user[last_name]', with: last_name
      fill_in 'user[password]', with: password
      fill_in 'user[password_confirmation]', with: password
      click_on'Create Account'

      expect(page).to have_content('Username already exists')
    end
    it 'cannot register with mismatched password' do
      email = 'timmy@gmail.com'
      first_name = 'Jim'
      last_name = 'Bob'
      password = 'password'

      visit register_path
      fill_in 'user[email]', with: email
      fill_in 'user[first_name]', with: first_name
      fill_in 'user[last_name]', with: last_name
      fill_in 'user[password]', with: password
      fill_in 'user[password_confirmation]', with: 'ddaf'
      click_on'Create Account'

      expect(page).to have_content("Passwords don't match")
    end
  end
end
