class RepositoryListResultFacade
  def self.user_repository_list(current_user)
    data = GithubService.new(current_user)
    repository_data = data.user_repositories
    if repository_data.first.include?(:id)
      repository_data.map do |repo_data|
        Repository.new(repo_data)
      end.sample(5)
    end
  end
end
