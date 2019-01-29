require 'rails_helper'

RSpec.describe RepositoryListResult, type: :model do
  before(:each) do
    @repositories = RepositoryListResult.new
  end
  
  it 'exists' do
    expect(@repositories).to be_a(RepositoryListResult)
  end

  it 'returns a list of all repositories' do
    VCR.use_cassette('repository_list_test') do
      @repositories.user_repository_list
    end
  end
end
