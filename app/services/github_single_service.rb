class GithubSingleService

  def initialize(github_user, oath_key)
    @github_user = github_user
    @oath_key = oath_key
  end

  def response_single_user
    get_json("users/#{@github_user}")
  end

  private
  def get_json(path)
    response = conn.get(path)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(:url => 'https://api.github.com') do |faraday|
      faraday.headers['Authorization'] = "token #{@oath_key}"
      faraday.adapter  Faraday.default_adapter
    end
  end
end
