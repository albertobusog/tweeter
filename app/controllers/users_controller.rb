class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    # render json: @user
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }
  end

  def create
    @user = User.new(create_params)
    if @user.save
      render json: @user
    else
      render json: @user.errors.full_messages
    end
  end

private
  def create_params
    params.require('user').permit('username', 'password', 'password_confirmation', 'full_name')
  end
end
