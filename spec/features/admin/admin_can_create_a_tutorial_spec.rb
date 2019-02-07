require 'rails_helper'

xfeature "An admin can create" do
  scenario "can create a new tutorial" do
    admin = create(:admin)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_tutorial_path

    fill_in "title", with: "Docker Container"
    fill_in "description", with: "Kickass Container Tech."
    fill_in "thumbnail", with: "https://www.google.com/url?sa=i&source=images&cd=&cad=rja&uact=8&ved=2ahUKEwi9p4fWjqngAhWTHDQIHXo2Bu0QjRx6BAgBEAU&url=%2Furl%3Fsa%3Di%26source%3Dimages%26cd%3D%26ved%3D%26url%3Dhttps%253A%252F%252Fwww.techrepublic.com%252Farticle%252Fdocker-the-smart-persons-guide%252F%26psig%3DAOvVaw25-tEYNTkPxtgJuL32okq1%26ust%3D1549611456594975&psig=AOvVaw25-tEYNTkPxtgJuL32okq1&ust=1549611456594975"
    click_on "Save"
    save_and_open_page
  end
end
