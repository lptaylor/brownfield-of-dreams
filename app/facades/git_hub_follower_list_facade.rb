class GitHubFollowerListFacade
  def self.user_github_followers_list(current_user, following_or_follower)
    data = GithubService.new(current_user)
    github_followers_data = data.user_github_followers(following_or_follower)
    if github_followers_data.first.include?(:id)
      github_followers_data.map do |follower_data|
        GitHubFollower.new(follower_data)
      end
    end
  end
end
