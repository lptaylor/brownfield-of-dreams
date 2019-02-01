class UsersController < ApplicationController
  def show
    @user = current_user
    repo_list = RepositoryListResultFacade.new(@user)
    @repositories = repo_list.user_repository_list
    follower_list = FollowerListFacade.new(@user)
    @followers = follower_list.user_followers_list
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

end
