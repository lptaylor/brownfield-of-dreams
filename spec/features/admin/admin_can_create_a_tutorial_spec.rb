require 'rails_helper'

feature "An admin can create" do
  scenario "can create a new tutorial" do
    admin = create(:admin)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit new_admin_tutorial_path

    fill_in 'tutorial_title', with: "Docker Container"
    fill_in "tutorial_description", with: "HIBBITY HOOPLA"
    fill_in "tutorial_thumbnail", with: "SOME.jpg"
    click_on "Save"

    expect(current_path).to eq(tutorial_path(Tutorial.last.id))
    expect(page).to have_content("Docker Container has been successfully added!")
  end

  scenario 'cannot create a tutorial if missing Thumbnail' do
    admin = create(:admin)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit new_admin_tutorial_path

    fill_in 'tutorial_title', with: "Docker Container"
    fill_in "tutorial_description", with: "HIBBITY HOOPLA"
    fill_in "tutorial_thumbnail", with: ""
    click_on "Save"

    expect(page).to have_content("Thumbnail can't be blank")
  end

  scenario 'cannot create a tutorial if missing description' do
    admin = create(:admin)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit new_admin_tutorial_path

    fill_in 'tutorial_title', with: "Docker Container"
    fill_in "tutorial_description", with: ""
    fill_in "tutorial_thumbnail", with: "dfssa"
    click_on "Save"

    expect(page).to have_content("Description can't be blank")
  end
  scenario 'cannot create a tutorial if missing Title' do
    admin = create(:admin)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit new_admin_tutorial_path

    fill_in 'tutorial_title', with: ""
    fill_in "tutorial_description", with: "HIBBITY HOOPLA"
    fill_in "tutorial_thumbnail", with: "dfas"
    click_on "Save"

    expect(page).to have_content("Title can't be blank")
  end
end
