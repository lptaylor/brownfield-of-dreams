class Follower
  attr_reader :uid, :handle, :html_url
  def initialize(attributes)
    @uid = attributes[:uid]
    @handle = attributes[:login]
    @html_url = attributes[:html_url]
  end

  def exists?
    true if User.find_by(uid: @uid)
  end
end
