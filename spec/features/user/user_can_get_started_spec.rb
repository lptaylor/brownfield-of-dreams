require 'rails_helper'

describe 'User' do
  it 'user can get started' do
    visit get_started_path
    expect(page).to have_content("Browse tutorials from the")
    expect(page).to have_content("Filter results by selecting a filter")
    expect(page).to have_content("Register to bookmark segments.")
  end
end
