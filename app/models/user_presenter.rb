class UserPresenter < User
  attr_reader :repositories, :github_followers, :github_following
  def initialize(current_user)
    super(current_user.attributes)
    @repositories = RepositoryListResultFacade.user_repository_list(current_user)
    @github_followers = GitHubFollowerListFacade.user_github_followers_list(current_user, "followers")
    @github_following = GitHubFollowerListFacade.user_github_followers_list(current_user, "following")
  end
end
