# Instance methods of json response when error occurs
module ErrorResponse
  extend ActiveSupport::Concern

  def respond_with_unauthorized
    render json: { errors: [
      {
        status: '401',
        title: 'Unauthorized',
      }
    ]
  }, status: :bad_request
  end
end