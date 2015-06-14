class Transaction < ActiveRecord::Base
  belongs_to :account

  validates :amount, :numericality => {:greater_than => 0}
  validates :category, inclusion: {in: Category.order(:name).map {|category| category.name}, message: 'has not been selected' }
  validates :transaction_type, inclusion: {in: %w(Deposit Withdrawal Transfer), message: 'has not been selected' }

  monetize :amount_cents

  def previous_transactions
    # grab all transactions belonging to my same account with date/time previous to my date/time
    Transaction.where("account_id = ? AND created_at < ?", self.account_id, self.created_at).order(:created_at)
    # Exercise: What SQL is generated from the statement above?
  end

  def amount_multiplier
    # added .to_s to ensure nil does not crash app with old data, yet defaults to positive
    self.transaction_type.to_s.downcase == 'withdrawal' ? -1 : 1
  end

  def applied_amount
    amount_multiplier * self.amount
  end

  def old_balance
    previous_transactions.map do |transaction| 
      transaction.applied_amount
    end.sum
  end

  def new_balance
    old_balance + self.applied_amount
  end

  def self.category_list
    #list of categories for form
    Category.order(:name).map {|category| category.name.to_s }
  end
end
