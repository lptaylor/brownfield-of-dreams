class GithubService

  private

  def conn
    Faraday.new(url: "https://api.github.com/user/repos") do |f|
      f.adapter  Faraday.default_adapter
      f.params[:key] = ENV['']
    end
  end

end
