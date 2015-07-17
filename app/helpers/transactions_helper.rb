module TransactionsHelper
  def current_user_account_transaction_path(extra_params)
    @transaction.id ? account_transaction_path(@account, @transaction, extra_params) : account_transactions_path(extra_params)
  end
end
