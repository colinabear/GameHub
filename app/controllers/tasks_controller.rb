class TasksController < ApplicationController
  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.create(params[:task].permit(:title, :description, :status, :job_type))
    @task.user_id = current_user.id if current_user
    @task.accepted = false
    @task.status = "todo"
    @task.save

    if @task.save
      redirect_to project_hub_path(@project)
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
    @included = false
    @task.project.tasks.reverse_each do |task|
      if task.id != @task.id
        if task.user_id == @task.user_id
          @included = true
        end
      end
    end
    if !@included && @project.user_id != current_user.id
      @array = @task.project.team_members
      @array.delete(@task.user_id)
      @task.project.update_attribute(:team_members, @array)
    end
    @task.destroy
    redirect_to project_path(@project)
  end

# Task sorting and searching
  def index
    if params[:sorttype] == 'programming'
      @tasks = Task.where(:status => "todo").where(:job_type => "Programming").page params[:page]
      if params[:sort] == 'updated_at'
        @tasks = @tasks.order("updated_at ASC")
      elsif params[:sort] == 'name'
        @tasks = @tasks.order("LOWER(title) DESC")
      elsif params[:sort] == 'name_reverse'
        @tasks = @tasks.order("LOWER(title) ASC")
      else
        @tasks = @tasks.order("created_at ASC")
      end
    elsif params[:sorttype] == 'music'
      @tasks = Task.where(:status => "todo").where(:job_type => "Music").page params[:page]
      if params[:sort] == 'updated_at'
        @tasks = @tasks.order("updated_at ASC")
      elsif params[:sort] == 'name'
        @tasks = @tasks.order("LOWER(title) DESC")
      elsif params[:sort] == 'name_reverse'
        @tasks = @tasks.order("LOWER(title) ASC")
      else
        @tasks = @tasks.order("created_at ASC")
      end
    elsif params[:sorttype] == 'art'
      @tasks = Task.where(:status => "todo").where(:job_type => "Art").page params[:page]
      if params[:sort] == 'updated_at'
        @tasks = @tasks.order("updated_at ASC")
      elsif params[:sort] == 'name'
        @tasks = @tasks.order("LOWER(title) DESC")
      elsif params[:sort] == 'name_reverse'
        @tasks = @tasks.order("LOWER(title) ASC")
      else
        @tasks = @tasks.order("created_at ASC")
      end
    elsif params[:sorttype] == 'story'
      @tasks = Task.where(:status => "todo").where(:job_type => "Story").page params[:page]
      if params[:sort] == 'updated_at'
        @tasks = @tasks.order("updated_at ASC")
      elsif params[:sort] == 'name'
        @tasks = @tasks.order("LOWER(title) DESC")
      elsif params[:sort] == 'name_reverse'
        @tasks = @tasks.order("LOWER(title) ASC")
      else
        @tasks = @tasks.order("created_at ASC")
      end
    elsif params[:sorttype] == 'level'
      @tasks = Task.where(:status => "todo").where(:job_type => "Level").page params[:page]
      if params[:sort] == 'updated_at'
        @tasks = @tasks.order("updated_at ASC")
      elsif params[:sort] == 'name'
        @tasks = @tasks.order("LOWER(title) DESC")
      elsif params[:sort] == 'name_reverse'
        @tasks = @tasks.order("LOWER(title) ASC")
      else
        @tasks = @tasks.order("created_at ASC")
      end
    elsif params[:sorttype] == 'puzzles'
      @tasks = Task.where(:status => "todo").where(:job_type => "Puzzles").page params[:page]
      if params[:sort] == 'updated_at'
        @tasks = @tasks.order("updated_at ASC")
      elsif params[:sort] == 'name'
        @tasks = @tasks.order("LOWER(title) DESC")
      elsif params[:sort] == 'name_reverse'
        @tasks = @tasks.order("LOWER(title) ASC")
      else
        @tasks = @tasks.order("created_at ASC")
      end
    elsif params[:sorttype] == 'misc'
      @tasks = Task.where(:status => "todo").where(:job_type => "Miscellaneous").page params[:page]
      if params[:sort] == 'updated_at'
        @tasks = @tasks.order("updated_at ASC")
      elsif params[:sort] == 'name'
        @tasks = @tasks.order("LOWER(title) DESC")
      elsif params[:sort] == 'name_reverse'
        @tasks = @tasks.order("LOWER(title) ASC")
      else
        @tasks = @tasks.order("created_at ASC")
      end
    else
      @tasks = Task.where(:status => "todo").page params[:page]
      if params[:sort] == 'updated_at'
        @tasks = @tasks.order("updated_at ASC")
      elsif params[:sort] == 'name'
        @tasks = @tasks.order("LOWER(title) DESC")
      elsif params[:sort] == 'name_reverse'
        @tasks = @tasks.order("LOWER(title) ASC")
      else
        @tasks = @tasks.order("created_at ASC")
      end
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def progress_task
    @task = Task.find(params[:task_id])
    @task.update_attribute(:status, "recent")
    # Review
    redirect_to @task.project
  end

  def review_task
    @task = Task.find(params[:taskid])
    @user = @task.user
    @num = params[:rating].to_s
    @num = @num[7].to_i
    if @num == 0
        @num = 1
    end
    if(@task.job_type == "Programming")
      @num = @num.to_i + @user.programming_rating.to_i
      @user.update_attribute(:programming_rating, @num)
    elsif(@task.job_type == "Art")
      @num = @num.to_i + @user.art_rating.to_i
      @user.update_attribute(:art_rating, @num)
    elsif(@task.job_type == "Music")
      @num = @num.to_i + @user.music_rating.to_i
      @user.update_attribute(:music_rating, @num)
    elsif(@task.job_type == "Level Design")
      @num = @num.to_i + @user.level_design_rating.to_i
      @user.update_attribute(:level_design_rating, @num)
    elsif(@task.job_type == "Story")
      @num = @num.to_i + @user.story_rating.to_i
      @user.update_attribute(:story_rating, @num)
    elsif(@task.job_type == "Puzzles")
      @num = @num.to_i + @user.puzzles_rating.to_i
      @user.update_attribute(:puzzles_rating, @num)
    elsif(@task.job_type == "Miscellaneous")
      @num = @num.to_i + @user.misc_rating.to_i
      @user.update_attribute(:misc_rating, @num)
    end
    @task.update_attribute(:reviewed, true);
    redirect_to @task.project
  end

  def regress_task
    @task = Task.find(params[:task_id])
    @task.update_attribute(:status, "inProg")
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
    @array = @task.project.team_members
    if !@array.include? @user.email
      @array << @user.id
      @task.project.update_attribute(:team_members, @array)
    end
    redirect_to @task
  end

  def drop_task
    @task = Task.find(params[:task_id])
    @array = @task.pending_users
    @array.delete(@task.user.id)
    @task.update_attribute(:pending_users, @array)
    @included = false
    @task.project.tasks.reverse_each do |task|
      if task.id != @task.id
        if task.user_id == @task.user_id
          @included = true
        end
      end
    end
    if !@included
      @array = @task.project.team_members
      @array.delete(@task.user_id)
      @task.project.update_attribute(:team_members, @array)
    end
    @task.user_id = @task.project.user_id
    @task.update_attribute(:accepted, false)
    @task.update_attribute(:status, "todo")
    redirect_to @task
  end
end
