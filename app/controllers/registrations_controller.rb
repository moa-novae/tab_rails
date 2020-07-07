class RegistrationsController < Devise::RegistrationsController
  respond_to :json
  def create
    @user = User.new(user_params)
    if @user.save
      print 'User created'
      render_resource(resource)
    else
      print @user.errors.full_messages
    end
  end

  private

  def user_params 
    params.require(:user).permit(:password, :phone, :name)
  end

end