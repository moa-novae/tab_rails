class GroupsController < ApplicationController
  before_action :authenticate_user!
  def index
    render :json => {groups: current_user.groups}
  end
end
