class GitHubSessionsController < ApplicationController
  def create
    @user = current_user
    @user.update_attributes(token: auth_hash)
    @user.update_attributes(github_username: github_username)
    @user.save
    redirect_to '/dashboard'
  end

  private
  def auth_hash
    request.env['omniauth.auth']['credentials']['token']
  end

  def github_username
    request.env['omniauth.auth']['extra']['raw_info']['login']
  end
end
