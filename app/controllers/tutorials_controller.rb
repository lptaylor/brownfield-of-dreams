class TutorialsController < ApplicationController
  def show
    @tutorial = Tutorial.find(params[:id])
    @facade = TutorialFacade.new(@tutorial, params[:video_id])
    if current_user.admin?
      @facade
    else
      if @facade.current_video

      else
        flash[:error] = "Sorry, This tutorial is empty"
        redirect_to root_path
      end
    end
  end
end
