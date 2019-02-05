require 'rails_helper'

describe User do
  it 'user can send an invite' do
    VCR.use_cassette('github_user_data') do
      username = "NickLindeberg"

      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user) {user}

      visit dashboard_path

      within(".email-friend-invite")do
        click_link("Send an Invite")
      end

      expect(current_path).to eq("/invite")
      fill_in "github", with: username

      click_on("Send Invite")
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Successfully sent invite!")
    end
  end

  it "user can't send an invite to peaple that don't exist" do
    VCR.use_cassette('github_non_user_data') do
      username = "NickLindeberg"

      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user) {user}

      visit dashboard_path

      within(".email-friend-invite")do
        click_link("Send an Invite")
      end

      expect(current_path).to eq("/invite")
      fill_in "github", with: "randomeness"

      click_on("Send Invite")
      expect(current_path).to eq(invite_path)
      expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
    end
  end
end
