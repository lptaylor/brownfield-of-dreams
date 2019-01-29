class GithubService

  def conn
    Faraday.new(url: "https://api.github.com") do |f|
      f.adapter  Faraday.default_adapter
      f.headers[:Authorization] = "token #{ENV['GIT_HUB_PLACEHOLDER_KEY']}"
    end
  end

  def user_repositories
    response = conn.get("/user/repos")
    JSON.parse(response.body, symbolize_names: true)
  end


end
