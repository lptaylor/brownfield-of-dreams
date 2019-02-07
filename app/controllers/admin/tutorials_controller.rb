class Admin::TutorialsController < Admin::BaseController
  def new
    @tutorial = Tutorial.new
  end

  def create
    @tutorial = Tutorial.create(create_tutoral_params)
    if @tutorial.save
      redirect_to tutorial_path(@tutorial.id)
      flash[:success] = "#{@tutorial.title} has been successfully added!"
    else
      render :new
    end
  end

  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def update
    tutorial = Tutorial.find(params[:id])
    if tutorial.update(tutorial_params)
      flash[:success] = "#{tutorial.title} tagged!"
    end
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  private
  def tutorial_params
    params.require(:tutorial).permit(:tag_list)
  end

  def create_tutoral_params
    params.require(:tutorial).permit(:title, :description, :thumbnail)
  end
end
