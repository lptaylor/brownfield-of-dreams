class BookmarkListFacade
  def self.bookmarks(current_user)
    current_user.videos.order(:tutorial_id, :position)
  end
end
