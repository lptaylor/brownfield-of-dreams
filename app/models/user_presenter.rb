class UserPresenter < User
  attr_reader :repositories, :followers, :following
  def initialize(current_user)
    super(current_user.attributes)
    @repositories = RepositoryListResultFacade.user_repository_list(current_user)
    @followers = FollowerListFacade.user_followers_list(current_user, "followers")
    @following = FollowerListFacade.user_followers_list(current_user, "following")
  end
end
