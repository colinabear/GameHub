class ResumesController < ApplicationController
  before_action :find_resume, only: [:show, :edit, :update, :destroy]
  def new
		@resume = current_user.build_resume
	end

	def create
		@resume = current_user.build_resume(resume_params)

		if @resume.save
			redirect_to user_resume_search_path(current_user)
		else
			render 'new'
		end
	end

  def edit
  end

  def update
		if @resume.update(resume_params)
			redirect_to user_resume_search_path(current_user)
		else
			render 'edit'
		end
	end

  private
  def find_resume
    @resume = Resume.find(params[:id])
  end

  def resume_params
		params.require(:resume).permit(:name, :location, :phone_number, :biography, :avatar)
	end
end
