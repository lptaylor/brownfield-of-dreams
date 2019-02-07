class FriendshipController < ApplicationController
  def create
    if current_user.already_friends?(params[:friend_uid])
      flash[:error] = 'Not a Valid User'
      redirect_to dashboard_path
    else
      current_user.add_friend(params[:friend_uid])
      flash[:success] = 'You are now Friends!'
      redirect_to dashboard_path
    end
  end
end
