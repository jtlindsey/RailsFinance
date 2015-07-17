class DocumentsController < ApplicationController
  helper :transactions
  before_action :authenticate_user!  
  before_action :set_account, only: [:index]
  before_action :set_transaction, only: [:index]

  def index    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = current_user.accounts.find(params[:account_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = @account.transactions.find(params[:transaction_id])
    end
end
