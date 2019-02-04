class GitHubSessionsController < ApplicationController
  def create
    @user = current_user
    @user.update_attributes(token: auth_hash)
    @user.save
    redirect_to '/dashboard'
  end

  private
  def auth_hash
    request.env['omniauth.auth']['credentials']['token']
  end

end
