class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def resume_search
    @user = User.find(params[:user_id])
    render 'users/account'
  end

  def new_message
    @user = User.find(params[:user_id])
    render 'new_message'
  end

  def message
    @message = params[:message]
    @user = User.find(params[:userid])
    if @user.messages_received == nil
      @user.messages_received = []
    end
    @array = @user.messages_received
    @array << @message
    @user.update_attribute(:messages_received, @array)
    if current_user.messages_sent == nil
      current_user.messages_sent= []
    end
    @array = current_user.messages_sent
    @array << @message
    current_user.update_attribute(:messages_sent, @array)
    # Need to redirect back to account that you sent message to.
  end
end
