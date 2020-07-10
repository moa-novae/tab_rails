class TransactionsController < ApplicationController
  before_action :authenticate_user!
  include ErrorResponse
  def index
    render :json => {transactions: current_user.transactions}
  end

  def create
    # check if user belongs in group
    if Group.find(transaction_params[:group_id]).user?(transaction_params[:user_id])
      Transaction.create(transaction_params)
    else 
      respond_with_unauthorized
    end
  end

  def show
    transaction = Transaction.find(params[:id])
    if transaction.group.user?(current_user.id)
      render :json => {transaction: transaction}
    else
      respond_with_unauthorized
    end
  end


  def update
    # if current user belongs in group
    if Transaction.find(params[:id]).group.user?(current_user.id)
      Transaction.update(update_params)
    else 
      respond_with_unauthorized
    end
  end

  private
  def transaction_params
    params.require(:transaction).permit(
      :amount, :user_id, :group_id, :transaction_date
    )
  end

  def update_params
    params.require(:transaction).permit(
      :amount, :transaction_date
    )
  end
end
