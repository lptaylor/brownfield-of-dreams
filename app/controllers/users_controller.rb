class UsersController < ApplicationController
  def show
    @user = current_user
    repo_list = RepositoryListResultFacade.new(@user)
    @repositories = repo_list.user_repository_list
  end

  def new
    @user = User.new
  end

  # def create
  #   user = User.create(user_params)
  #   if user.save
  #     session[:user_id] = user.id
  #     redirect_to dashboard_path
  #   else
  #     flash[:error] = 'Username already exists'
  #     render :new
  #   end
  # end

  def create
    if params[:user][:password] != params[:user][:password_confirmation]
      flash[:error] = "Passwords don't match"
      redirect_to register_path
    else
      user = User.create(user_params)
      if user.save
        session[:user_id] = user.id
        flash[:alert] = "Logged in as #{user.first_name} #{user.last_name}"
        flash[:notice] = "This account has not yet been activated. Please check your email."

        ConfirmationMailer.success(current_user).deliver_now

        redirect_to dashboard_path
      else
        flash[:error] = 'Username already exists'
        render :new
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

end
