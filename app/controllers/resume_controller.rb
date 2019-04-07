class ResumeController < ApplicationController
  def edit
  end

  def update
    if @resume.update(resume_params)
      redirect_to @resume
    else
      render 'edit'
    end
  end
end
