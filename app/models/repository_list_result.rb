class RepositoryListResult

  def user_repository_list
    data = GithubService.new
    repository_data = data.user_repositories
    repository_data.map do |repo_data|
      Repository.new(repo_data)
    end
  end
end
