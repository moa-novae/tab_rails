class UsersController < ApplicationController
  before_action :authenticate_user!
  # send current user
  def index
    @user = current_user
    render json: @user
  end

  def show
    @user = User.find(params[:id])
    render json: @user.as_json(only: [:name], methods: [:user_overall_balance])
  end

  def update
    if current_user.id == params[:id].to_i
      current_user.update(update_user_params)
    else
      render json: { errors: [
        {
          status: '401',
          title: 'Unauthorized',
        }
      ]
    }, status: :bad_request
    end
  end

  private
  def update_user_params
    params.require(:user).permit(:id, :name, :phone, :email)
  end

end
