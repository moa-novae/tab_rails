class GroupsController < ApplicationController
  before_action :authenticate_user!
  include ErrorResponse
  def index
    render json: {groups: current_user.groups}
  end

  def show
    @group = Group.find(params[:id])
    if @group.users.include? current_user
      render json: @group
    else
      respond_with_unauthorized
    end
  end

  def create
    @group = Group.create(group_params)
    @members = member_params.map do |member|
      {user_id: member, group_id: @group.id}
    end
    UserGroup.create(@members)
    # respond with 201 and location header
    response.set_header('Location', "/api/groups/#{@group.id}")
    render json: @group, status: :created
  end

  def update
    # only allow update if user belongs in group
    @group = Group.find(params[:id])
    if @group.user?(current_user.id)
      @group.update(update_params)
    else 
      respond_with_unauthorized
    end
  end

  def destroy 
    @group = Group.find(params[:id])
    if @group.user?(current_user.id)
      @group.delete 
    else 
      respond_with_unauthorized
    end
  end

  private
  def group_params
    params.require(:group).permit(:name, :description)
  end

  def member_params
    params.permit(members: [])
    params.require(:members)
  end

  def update_params
    params.require(:group).permit(:name, :description)
  end
end
