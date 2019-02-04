class FollowerListFacade
  def self.user_followers_list(current_user, following_or_follower)
    data = GithubService.new(current_user)
    followers_data = data.user_followers(following_or_follower)
    if followers_data.first.include?(:id)
      followers_data.map do |follower_data|
        Follower.new(follower_data)
      end
    end
  end
end
