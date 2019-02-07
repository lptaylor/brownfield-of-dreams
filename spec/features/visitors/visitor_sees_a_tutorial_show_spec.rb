require 'rails_helper'

describe 'visitor sees a Tutorial show' do
  it 'redirects if tutorial is empty' do
    tutorial = create(:tutorial)

    visit '/'

    click_on tutorial.title
    expect(current_path).to eq(root_path)
    expect(page).to have_content("Sorry, This tutorial is empty")
  end
end
