class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def resume_search
    @user = User.find(params[:user_id])
    render 'users/account'
  end
end
