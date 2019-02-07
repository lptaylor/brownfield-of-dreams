class FriendshipMailer < ApplicationMailer
  def friendship(facade)
    @facade = facade
    mail(to: @facade.friend_email, subject: "Join The Dark Side of Turing Tutorials")
  end
end
