class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = current_user
    render json: @user
  end

  def show 
    @user = User.find(params[:id])
    render json: @user.as_json(only: [:name], methods: [:user_overall_balance])
  end
end
