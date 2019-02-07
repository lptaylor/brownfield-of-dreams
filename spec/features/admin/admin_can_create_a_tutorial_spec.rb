require 'rails_helper'

feature "An admin can create" do
  scenario "can create a new tutorial" do
    admin = create(:admin)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_tutorial_path

    fill_in 'tutorial_title', with: "Docker Container"
    fill_in "tutorial_description", with: "Kickass Container Tech."
    fill_in "tutorial_thumbnail", with: "https://www.google.com/url?sa=i&source=images&cd=&cad=rja&uact=8&ved=2ahUKEwi9p4fWjqngAhWTHDQIHXo2Bu0QjRx6BAgBEAU&url=%2Furl%3Fsa%3Di%26source%3Dimages%26cd%3D%26ved%3D%26url%3Dhttps%253A%252F%252Fwww.techrepublic.com%252Farticle%252Fdocker-the-smart-persons-guide%252F%26psig%3DAOvVaw25-tEYNTkPxtgJuL32okq1%26ust%3D1549611456594975&psig=AOvVaw25-tEYNTkPxtgJuL32okq1&ust=1549611456594975"
    click_on "Save"

    expect(current_path).to eq(tutorial_path(Tutorial.last.id))
    expect(page).to have_content("Docker Container has been successfully added!")
  end
#
#   When I visit '/admin/tutorials/new'
# And I fill in 'title' with a meaningful name
# And I fill in 'description' with a some content
# And I fill in 'thumbnail' with a valid YouTube thumbnail
# And I click on 'Save'
# Then I should be on '/tutorials/{NEW_TUTORIAL_ID}'
# And I should see a flash message that says "Successfully created tutorial."
end
