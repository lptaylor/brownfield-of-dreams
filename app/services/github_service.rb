class GithubService
  def initialize(current_user)
    @user = current_user
  end

  def conn
    Faraday.new(url: "https://api.github.com") do |f|
      f.adapter  Faraday.default_adapter
      f.headers[:Authorization] = @user[:token]
    end
  end

  def user_repositories
    response = conn.get("/user/repos")
    JSON.parse(response.body, symbolize_names: true)
  end

  def user_followers(api_path)
    response = conn.get("/user/#{api_path}")
    JSON.parse(response.body, symbolize_names: true)
  end
end
