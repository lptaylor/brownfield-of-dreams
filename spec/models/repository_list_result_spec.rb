require 'rails_helper'

RSpec.describe RepositoryListResult, type: :model do
  before(:each) do
    VCR.use_cassette('repository_list_test') do
      @repositories = RepositoryListResult.user_repository_list
    end
  end

  it 'exists' do
    repositories = RepositoryListResult.new
    expect(repositories).to be_a(RepositoryListResult)
  end

  it 'returns a list of all repositories' do
  end
end
