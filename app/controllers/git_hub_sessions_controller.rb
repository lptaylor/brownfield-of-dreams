class GitHubSessionsController < ApplicationController
  def create
    @user = current_user
    @user.update_attributes(token: auth_hash['credentials']['token'], uid: auth_hash['uid'] )
    @user.update_attributes(github_username: auth_hash['extra']['raw_info']['login'])
    @user.save
    redirect_to '/dashboard'
  end

  private
  def auth_hash
    request.env['omniauth.auth']
  end
end
