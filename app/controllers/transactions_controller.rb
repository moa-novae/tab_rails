class TransactionsController < ApplicationController
  before_action :authenticate_user!
  def index
    render :json => {transactions: current_user.transactions}
  end

  def create
    # check if user belongs in group
    if Group.find(transaction_params[:group_id]).user?(transaction_params[:user_id])
      Transaction.create(transaction_params)
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
  def transaction_params
    params.require(:transaction).permit(
      :amount, :user_id, :group_id, :transaction_date
    )
  end
end
