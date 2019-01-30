require 'rails_helper'

RSpec.describe RepositoryListResultFacade, type: :model do
  before(:each) do
    VCR.use_cassette('repository_list_test') do
      @user = create(:user)
      repo_list = RepositoryListResultFacade.new(@user)
      @repositories = repo_list.user_repository_list
    end
  end

  it 'exists' do
    repositories = RepositoryListResultFacade.new(@user)
    expect(repositories).to be_a(RepositoryListResultFacade)
  end

  it 'returns a list of all repositories' do
    expect(@repositories).to be_a(Array)
  end
end
