class EmailValidationController < ApplicationController
  def create
    user = User.find(params[:id])
    user.status == true
    # binding.pry
    user.save!
    redirect_to(welcome_thanks_path)
  end

  def show
  end
end
