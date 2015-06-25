class Transaction < ActiveRecord::Base
  belongs_to :account

  validates :amount, :numericality => {:greater_than => -0.0001, message: 'should be greater than 0'}
  validates :category, inclusion: {in: Category.order(:name).map {|category| category.name}, message: 'has not been selected' }
  #validates :transaction_type, inclusion: {in: %w(Deposit Withdrawal Transfer), message: 'has not been selected' }

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

  def self.transaction_type
    #list of transaction types
    %w(Deposit Withdrawal Transfer)
  end

  def self.category_list
    #list of categories for form
    [
      ['Income', Category.where(category_type: 'Income').order('LOWER(name)').map {|category| category.name.to_s }],
      ['Expense', Category.where(category_type: 'Expense').order('LOWER(name)').map {|category| category.name.to_s }]
    ]
  end

  def self.deposit_category_list
    [
      ['Income', Category.where(category_type: 'Income').order('LOWER(name)').map {|category| category.name.to_s }]
    ]
  end

  def self.withdrawal_category_list
    [
      ['Expense', Category.where(category_type: 'Expense').order('LOWER(name)').map {|category| category.name.to_s }]
    ]
  end

  def self.transfer_category_list
    [
      ['Transfer', ['Pay-Bill-Transfer','Other-Transfer']]
    ]
  end
  
  # def self.account_list
  #   #list all accounts except current for account transfer
  #   @account_transfer_list = Account.order('LOWER(name)').where.not(id: @account.id).map do |account| 
  #     "#{account.name} #{account.last4} #{account.type}"
  #   end
  # end        
end
