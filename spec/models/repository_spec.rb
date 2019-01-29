require 'rails_helper'

RSpec.describe Repository, type: :model do
  before(:each) do
    @repository = Repository.new(name: "test-repo", html_url: "https://something")

  end
  it 'exists' do
    expect(@repository).to be_a(Repository)
  end

  it 'has attributes' do
    expect(@repository.name).to eq("test-repo")
    expect(@repository.html_url).to eq("https://something")
  end
end
