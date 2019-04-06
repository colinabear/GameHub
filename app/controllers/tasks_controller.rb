class TasksController < ApplicationController
  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.create(params[:task].permit(:title, :description, :status, :job_type))
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
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id])
  end

  def update
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id])

    if @task.update(params[:task].permit(:title, :description, :status, :job_type))
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
    if params[:sorttype] == 'programming'
      if params[:sort] == 'updated_at'
        @tasks = Task.where(:status => "todo").where(:job_type => "Programming").order("updated_at DESC")
      elsif params[:sort] == 'name'
        @tasks = Task.where(:status => "todo").where(:job_type => "Programming").order("title ASC")
      elsif params[:sort] == 'name_reverse'
        @tasks = Task.where(:status => "todo").where(:job_type => "Programming").order("title DESC")
      else
        @tasks = Task.where(:status => "todo").where(:job_type => "Programming").order("created_at DESC")
      end
    elsif params[:sorttype] == 'music'
      if params[:sort] == 'updated_at'
        @tasks = Task.where(:status => "todo").where(:job_type => "Music").order("updated_at DESC")
      elsif params[:sort] == 'name'
        @tasks = Task.where(:status => "todo").where(:job_type => "Music").order("title ASC")
      elsif params[:sort] == 'name_reverse'
        @tasks = Task.where(:status => "todo").where(:job_type => "Music").order("title DESC")
      else
        @tasks = Task.where(:status => "todo").where(:job_type => "Music").order("created_at DESC")
      end
    elsif params[:sorttype] == 'art'
      if params[:sort] == 'updated_at'
        @tasks = Task.where(:status => "todo").where(:job_type => "Art").order("updated_at DESC")
      elsif params[:sort] == 'name'
        @tasks = Task.where(:status => "todo").where(:job_type => "Art").order("title ASC")
      elsif params[:sort] == 'name_reverse'
        @tasks = Task.where(:status => "todo").where(:job_type => "Art").order("title DESC")
      else
        @tasks = Task.where(:status => "todo").where(:job_type => "Art").order("created_at DESC")
      end
    elsif params[:sorttype] == 'story'
      if params[:sort] == 'updated_at'
        @tasks = Task.where(:status => "todo").where(:job_type => "Story").order("updated_at DESC")
      elsif params[:sort] == 'name'
        @tasks = Task.where(:status => "todo").where(:job_type => "Story").order("title ASC")
      elsif params[:sort] == 'name_reverse'
        @tasks = Task.where(:status => "todo").where(:job_type => "Story").order("title DESC")
      else
        @tasks = Task.where(:status => "todo").where(:job_type => "Story").order("created_at DESC")
      end
    elsif params[:sorttype] == 'level'
      if params[:sort] == 'updated_at'
        @tasks = Task.where(:status => "todo").where(:job_type => "Level Design").order("updated_at DESC")
      elsif params[:sort] == 'name'
        @tasks = Task.where(:status => "todo").where(:job_type => "Level Design").order("title ASC")
      elsif params[:sort] == 'name_reverse'
        @tasks = Task.where(:status => "todo").where(:job_type => "Level Design").order("title DESC")
      else
        @tasks = Task.where(:status => "todo").where(:job_type => "Level Design").order("created_at DESC")
      end
    elsif params[:sorttype] == 'puzzles'
      if params[:sort] == 'updated_at'
        @tasks = Task.where(:status => "todo").where(:job_type => "Puzzles").order("updated_at DESC")
      elsif params[:sort] == 'name'
        @tasks = Task.where(:status => "todo").where(:job_type => "Puzzles").order("title ASC")
      elsif params[:sort] == 'name_reverse'
        @tasks = Task.where(:status => "todo").where(:job_type => "Puzzles").order("title DESC")
      else
        @tasks = Task.where(:status => "todo").where(:job_type => "Puzzles").order("created_at DESC")
      end
    elsif params[:sorttype] == 'misc'
      if params[:sort] == 'updated_at'
        @tasks = Task.where(:status => "todo").where(:job_type => "Miscellaneous").order("updated_at DESC")
      elsif params[:sort] == 'name'
        @tasks = Task.where(:status => "todo").where(:job_type => "Miscellaneous").order("title ASC")
      elsif params[:sort] == 'name_reverse'
        @tasks = Task.where(:status => "todo").where(:job_type => "Miscellaneous").order("title DESC")
      else
        @tasks = Task.where(:status => "todo").where(:job_type => "Miscellaneous").order("created_at DESC")
      end
    else
      if params[:sort] == 'updated_at'
        @tasks = Task.where(:status => "todo").order("updated_at DESC")
      elsif params[:sort] == 'name'
        @tasks = Task.where(:status => "todo").order("title ASC")
      elsif params[:sort] == 'name_reverse'
        @tasks = Task.where(:status => "todo").order("title DESC")
      else
        @tasks = Task.where(:status => "todo").order("created_at DESC")
      end
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

  def request_task
    @task = Task.find(params[:task_id])
    @array = @task.pending_users
    @array << current_user.id
    @task.update_attribute(:pending_users, @array)
    redirect_to @task
  end

  def accept_user
    @task = Task.find(params[:task_id])
    @user = User.find(params[:user_id])
    @task.user_id = @user.id
    @task.accepted = true
    @task.status = "inProg"
    @user.tasks << @task
    redirect_to @task
  end

  def drop_task
    @task = Task.find(params[:task_id])
    @array = @task.pending_users
    @array.delete(@task.user.id)
    @task.update_attribute(:pending_users, @array)
    @task.user_id = @task.project.user_id
    @task.update_attribute(:accepted, false)
    @task.update_attribute(:status, "todo")
    redirect_to @task
  end
end
