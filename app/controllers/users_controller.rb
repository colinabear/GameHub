class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def resume_search
    @user = User.find(params[:user_id])
    render 'users/account'
  end

  def new_message
    @user = Project.find(params[:user_id])
    render 'new_message'
  end

  def message
    @user = User.find(params[:userid])
    @array = @user.messages_received
    @array << :message.to_s
    @user.update_attribute(:messages_received, @array)
    @array = current_user.messages_sent
    @array << :message.to_s
    current_user.update_attribute(:messages_sent, @array)
    user_resume_search_path(@user)
  end
end
