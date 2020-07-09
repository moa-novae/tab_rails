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

  def create
    @group = Group.create(group_params)
    @members = member_params.map do |member|
      {user_id: member, group_id: @group.id}
    end
    UserGroup.create(@members)

  end
  private
  def group_params 
    params.require(:group).permit(:name, :description)
  end

  def member_params
    params.permit(members: [])
    params.require(:members)
  end
end
