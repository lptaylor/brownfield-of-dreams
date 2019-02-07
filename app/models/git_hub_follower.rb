class GitHubFollower
  attr_reader :id, :handle, :html_url
  def initialize(attributes)
    @id = attributes[:id]
    @handle = attributes[:login]
    @html_url = attributes[:html_url]
  end

  def exists?
    true if User.find_by(uid: @id)
  end
end
