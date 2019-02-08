class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  has_many :friendships
  has_many :friends, through: :friendships

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, on: :create
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def add_friend(friend_uid)
    new_friend = User.find_by(uid: friend_uid)
    self.friends << new_friend
  end

  def already_friends?(friend_uid)
    friends.any? do |friend|
      friend.uid == friend_uid
    end
  end
end
