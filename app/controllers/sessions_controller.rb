class SessionsController < Devise::SessionsController
  respond_to :json
  private
  def respond_with(resource, _opts = {})
    render json: resource
    enddef respond_to_on_destroy
    head :ok
  end
end