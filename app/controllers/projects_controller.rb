class ProjectsController < ApplicationController
  before_action :find_project, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if params[:search]
  			if params[:sort] == 'updated_at'
		      @projects = Project.where('name LIKE ? OR description LIKE ? OR author LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%").order("updated_at DESC")
		    elsif params[:sort] == 'created_at'
		      @projects = Project.where('name LIKE ? OR description LIKE ? OR author LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%").order("created_at DESC")
				elsif params[:sort] == 'name'
					@projects = Project.where('name LIKE ? OR description LIKE ? OR author LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%").order("name ASC")
				elsif params[:sort] == 'name_reverse'
					@projects = Project.where('name LIKE ? OR description LIKE ? OR author LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%").order("name DESC")
				elsif params[:sort] == 'popularity'
					@projects = Project.where('name LIKE ? OR description LIKE ? OR author LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%").order(cached_votes_score: :desc)
				else
					@projects = Project.where('name LIKE ? OR description LIKE ? OR author LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%").order("created_at DESC")
				end
		else
				if params[:sort] == 'updated_at'
					@projects = Project.order("updated_at DESC")
				elsif params[:sort] == 'created_at'
					@projects = Project.all.order("created_at DESC")
				elsif params[:sort] == 'name'
					@projects = Project.all.order("name ASC")
				elsif params[:sort] == 'name_reverse'
					@projects = Project.all.order("name DESC")
				elsif params[:sort] == 'popularity'
					@projects = Project.all.order(cached_votes_score: :desc)
				else
					@projects = Project.all
				end
		end
  end

  def show
  end

  def new
    @project = current_user.projects.build
  end

  def create
    @project = current_user.projects.build(project_params)

    if @project.save
      redirect_to @project
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to @project
    else
      render 'edit'
    end
  end

  def destroy
    @project.tasks.each do |task|
      task.destroy
    end
    @project.destroy
    redirect_to project_index_path
  end

  def upvote
    @project = Project.find(params[:id])
    @project.upvote_by current_user
    redirect_to project_index_path
  end

  private

  def find_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description, :author, :team_members, :progress, :search)
  end

end
