class ProjectsController < ApplicationController
  before_action :find_project, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if params[:search]
        @projects = Project.where('name LIKE ? OR description LIKE ? OR author LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%").page params[:page]
  			if params[:sort] == 'updated_at'
		      @projects = @projects.order("updated_at DESC")
		    elsif params[:sort] == 'created_at'
		      @projects = @projects.order("created_at DESC")
				elsif params[:sort] == 'name'
					@projects = @projects.order("LOWER(name) ASC")
				elsif params[:sort] == 'name_reverse'
					@projects = @projects.order("LOWER(name) DESC")
				elsif params[:sort] == 'popularity'
					@projects = @projects.order(cached_votes_score: :desc)
				else
					@projects = @projects.order("created_at DESC")
				end
		else
        @projects =  Project.all.page params[:page]
				if params[:sort] == 'updated_at'
					@projects = @projects.order("updated_at DESC")
				elsif params[:sort] == 'created_at'
					@projects = @projects.order("created_at DESC")
				elsif params[:sort] == 'name'
					@projects = @projects.order("LOWER(name) ASC")
				elsif params[:sort] == 'name_reverse'
					@projects = @projects.order("LOWER(name) DESC")
				elsif params[:sort] == 'popularity'
					@projects = @projects.order(cached_votes_score: :desc)
				else
					@projects = @projects.order("created_at DESC")
				end
		end
  end

  def show
  end

  def available_tasks
    @project = Project.find(params[:project_id])
    render 'available_tasks'
  end

  def hub
    @project = Project.find(params[:project_id])
    render 'hub'
  end

  def new
    @project = current_user.projects.build
  end

  def create
    @project = current_user.projects.build(project_params)
    @project.team_members << current_user.id

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
    @project.tasks.reverse_each do |task|
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
    params.require(:project).permit(:name, :description, :author, :team_members, :progress, :search, :avatar)
  end

end
