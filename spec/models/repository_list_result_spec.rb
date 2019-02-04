require 'rails_helper'

RSpec.describe RepositoryListResultFacade, type: :model do
  before(:each) do
    VCR.use_cassette('github_api_data_repos') do
      @user = create(:user)
      @repositories = RepositoryListResultFacade.user_repository_list(@user)
    end
  end

  it 'returns a list of all repositories' do
    expect(@repositories).to be_a(Array)
    expect(@repositories[0]).to be_a(Repository)
  end
end
