class GroupsController < ApplicationController
  before_action :authenticate_user!
  def index
    render json: {groups: current_user.groups}
  end

  def show
    @group = Group.find(params[:id])
    render json: @group
  end
end
