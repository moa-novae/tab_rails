class TransactionsController < ApplicationController
  before_action :authenticate_user!
  def index
    render :json => {transactions: current_user.transactions}
  end
end
