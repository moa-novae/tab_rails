class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    if current_user[:id] == params[:id]
      @user = current_user
      render json: @user
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
end
