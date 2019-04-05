class TasksController < ApplicationController
  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.create(params[:task].permit(:title, :description, :status))
    @task.user_id = current_user.id if current_user
    @task.accepted = false
    @task.status = "todo"
    @task.save

    if @task.save
      redirect_to project_path(@project)
    else

    end
  end

  def edit
    @project = Project.find(params[:id])
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
    @project = Project.find(params[:id])
    @task = @project.tasks.find(params[:id])
    @task.destroy
    redirect_to project_path(@project)
  end

  def index
    if params[:sort] == 'updated_at'
      @tasks = Task.where(:status => "todo").order("updated_at DESC")
    elsif params[:sort] == 'created_at'
      @tasks = Task.where(:status => "todo").order("created_at DESC")
    elsif params[:sort] == 'name'
      @tasks = Task.where(:status => "todo").order("title ASC")
    elsif params[:sort] == 'name_reverse'
      @tasks = Task.where(:status => "todo").order("title DESC")
    elsif params[:sort] == 'popularity'
      @tasks = Task.where(:status => "todo").order(cached_votes_score: :desc)
    else
      @tasks = Task.where(:status => "todo").order("created_at DESC")
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def progress_task
    @task = Task.find(params[:task_id])
    @task.update_attribute(:status, "recent")
    redirect_to @task.project
  end

  def accept_task
    @task = Task.find(params[:task_id])
    @task.user_id = current_user.id if current_user
    @task.accepted = true
    @task.status = "inProg"
    current_user.tasks << @task
    redirect_to @task
  end

  def drop_task
    @task = Task.find(params[:task_id])
    @task.user_id = @task.project.user_id
    @task.update_attribute(:accepted, false)
    redirect_to @task
  end
end
