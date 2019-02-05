class InviteFacade

  def initialize(github_user, current_user)
    @github_user = github_user
    @current_user = current_user
    @_current_user_search_result
    @_friend_search_result
  end

  def friend_name
    friend_search_result.response_single_user[:name]
  end

  def user_name
    current_user_search_result.response_single_user[:name]
  end

  def friend_email
    friend_search_result.response_single_user[:email]
  end

  private
  def current_user_search_result
    # binding.pry
    @_current_user_search_result ||= service(@current_user.github_username)
  end

  def friend_search_result
    @_friend_search_result ||= service(@github_user)
  end

  def service(github_username)
    GithubSingleService.new(github_username, @current_user.token)
  end
end
