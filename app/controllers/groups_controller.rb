class GroupsController < ApplicationController
  before_action :authenticate_user!
  def index
    render json: {groups: current_user.groups}
  end

  def show
    @group = Group.find(params[:id])
    if @group.users.include? current_user
      render json: @group
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
