class GuestVideosController < ApplicationController
  def show
    redirect_back(fallback_location: root_path)
    flash[:notice] = "User must login to bookmark videos."
  end

end
