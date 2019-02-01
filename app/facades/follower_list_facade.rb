class FollowerListFacade
  def initialize(current_user)
    @user = current_user
  end

  def user_followers_list
    data = GithubService.new(@user)
    followers_data = data.user_followers
    if followers_data.first.include?(:id)
      followers_data.map do |follower_data|
        Follower.new(follower_data)
      end
    end
  end
end
