class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  # has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  # has_many :followees, through: :followed_users
  #
  # has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
  # has_many :followers, through: :following_users

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

  def friends_list
    friendships.map do |friendship|
      User.find(friendship.id)
    end
  end
end
