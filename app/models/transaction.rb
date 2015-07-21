class Transaction < ActiveRecord::Base
  MAX_DOCUMENT_COUNT = 5
  attr_accessor :remove_document

  belongs_to :account
  # has_one :linked_transaction, class: 'Transaction', foreign_key: 'transfer_ref'
  #belongs_to :deposit, class_name: "Transaction"

  validates :amount, :numericality => {:greater_than => -0.0001, message: 'should be greater than 0'}
  #validates :category, inclusion: {in: Category.order(:name).map {|category| category.name}, message: 'has not been selected' }
  #validates :transaction_type, inclusion: {in: %w(Deposit Withdrawal Transfer), message: 'has not been selected' }
  mount_uploaders :documents, DocumentUploader

  monetize :amount_cents

  before_destroy :delete_corresponding_transactions

  # for virtual attributes in transactions form, entire transfer form changed to virual attributes
  attr_accessor :from_account_id, :to_account_id

  def to_account_payee
  end

  def self.deposit_from_account_payee(from_account_id)
    a = Account.find_by(id: from_account_id)
    "From account: #{a.name} #{a.last4}"
  end

  def self.withdrawal_to_account_payee(to_account_id)
    a = Account.find_by(id: to_account_id)
    "To account: #{a.name} #{a.last4}"
  end

  # TODO look into exception implementations
  def self.transfer(amount, ocurred_on, from_account_id, to_account_id, comment, category, payee)
    ActiveRecord::Base.transaction do 
      @deposit_transaction = Transaction.create!(
        amount: amount, 
        date: ocurred_on, 
        transaction_type: "Deposit", 
        comment: comment, 
        category: category, 
        #payee: payee, 
        payee: deposit_from_account_payee(from_account_id),
        account_id: to_account_id
        #deposit
      )
      #byebug
      @withdrawal_transaction = Transaction.create!(
        amount: amount, 
        date: ocurred_on, 
        transaction_type: "Withdrawal", 
        comment: comment, 
        category: category, 
        payee: withdrawal_to_account_payee(to_account_id),  
        account_id: from_account_id, 
        transfer_ref: @deposit_transaction.id
      )

      @deposit_transaction.update_attributes(transfer_ref: @withdrawal_transaction.id)
      #byebug
      [@withdrawal_transaction, @deposit_transaction]
    end
  end


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

  def self.category_list(user)
    #list of categories for form
    [
      ['Income', user.categories.where(category_type: 'Income').order('LOWER(name)').map {|category| category.name.to_s }],
      ['Expense', user.categories.where(category_type: 'Expense').order('LOWER(name)').map {|category| category.name.to_s }]
    ]
  end

  def self.deposit_category_list(user)
    [
      ['Income', user.categories.where(category_type: 'Income').order('LOWER(name)').map {|category| category.name.to_s }]
    ]
  end

  def self.withdrawal_category_list(user)
    [
      ['Expense', user.categories.where(category_type: 'Expense').order('LOWER(name)').map {|category| category.name.to_s }]
    ]
  end

  def self.transfer_category_list
    [
      ['Transfer', ['Pay-Bill-Transfer','Other-Transfer']]
    ]
  end 

  # def self.account_transfer_list
  #   #list all accounts except current for account transfer
  #   @account_transfer_list = Account.order('LOWER(name)').where.not(id: @account.id).map do |account| 
  #     "#{account.name} #{account.last4} #{account.type}"
  #   end
  # end

  def delete_corresponding_transactions
    #destroy corresponding transactions
    if transfer_ref != nil
      linked_transaction = Transaction.find_by(id: transfer_ref)
      linked_transaction.delete
    end 
    #end destroy corresponding transactions
    true
  end

end

