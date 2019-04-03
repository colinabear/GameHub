class TasksController < ApplicationController
  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.create(params[:task].permit(:title, :description, :status))
    @task.user_id = current_user.id if current_user
    @task.accepted = false
    @task.save

    if @task.save
      redirect_to project_path(@project)
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:project_id])
    @task = @project.tasks.find(params[:id])
  end

  def update
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id])

    if @task.update(params[:task].permit(:title, :description, :status))
      redirect_to project_path(@project)
    else
      render 'edit'
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id])
    @task.destroy
    redirect_to project_path(@project)
  end

  def index
    if params[:sort] == 'updated_at'
      @tasks = Task.all.order("updated_at DESC")
    elsif params[:sort] == 'created_at'
      @tasks = Task.all.order("created_at DESC")
    elsif params[:sort] == 'name'
      @tasks = Task.all.order("title ASC")
    elsif params[:sort] == 'name_reverse'
      @tasks = Task.all.order("title DESC")
    elsif params[:sort] == 'popularity'
      @tasks = Task.all.order(cached_votes_score: :desc)
    else
      @tasks = Task.all.order("created_at DESC")
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def accept_task
    @task = Task.find(params[:task_id])
    @task.user_id = current_user.id if current_user
    @task.accepted = true
    current_user.tasks << @task
    redirect_to @task
  end
end
