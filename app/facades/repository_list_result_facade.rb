class RepositoryListResultFacade
  def initialize(current_user)
    @user = current_user
  end

  def user_repository_list
    data = GithubService.new(@user)
    repository_data = data.user_repositories
    if repository_data.first.include?(:id)
      repository_data.map do |repo_data|
        Repository.new(repo_data)
      end.sample(5)
    end
  end
end
