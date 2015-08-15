class Transaction < ActiveRecord::Base

  belongs_to :account
  has_many :documents, dependent: :destroy

  validates :amount, :numericality => {greater_than_or_equal_to: 0, message: 'should be greater than 0'}
  #validates :category, inclusion: {in: Category.order(:name).map {|category| category.name}, message: 'has not been selected' }
  validates :transaction_type, inclusion: {in: %w(Deposit Withdrawal Transfer Payment), message: 'has not been selected' }

  monetize :amount_cents
  monetize :interest_payment_cents
  monetize :principal_payment_cents
  monetize :payment_amount_cents

  before_save :calculate_mortgage_principal_interest_payment
  before_save :calculate_liability_payment_amount
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
        interest_payment: 0,
        principal_payment: 0,
        payment_amount: 0, 
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
        interest_payment: 0,
        principal_payment: 0,
        payment_amount: 0,
        payee: withdrawal_to_account_payee(to_account_id),  
        account_id: from_account_id, 
        transfer_ref: @deposit_transaction.id
      )

      @deposit_transaction.update_attributes(transfer_ref: @withdrawal_transaction.id)
      #byebug
      [@withdrawal_transaction, @deposit_transaction]
    end
  end

  # TODO look into exception implementations
  def self.payment(amount, ocurred_on, from_account_id, to_account_id, comment, category, payee, interest_payment, principal_payment, payment_amount, transfer_ref)
    amount = amount.to_f if amount.class == String
    payment_amount = payment_amount.to_f if payment_amount.class == String
    interest_payment = interest_payment.to_f if interest_payment.class == String
    principal_payment = principal_payment.to_f if principal_payment.class == String

    if Account.find_by(id: to_account_id).type == "Mortgage"
      @mortgage_account = Account.find_by(id: to_account_id)
      calculate_mortgage_principal_interest_payment_two(amount, payment_amount, interest_payment, principal_payment)
      @payment_amount = amount + payment_amount + interest_payment + principal_payment
      @interest_payment = @interest_payment + interest_payment
      @principal_payment = @principal_payment + principal_payment
      @total_payment_from_acc = @principal_payment
    else
      @total_payment_from_acc = amount + payment_amount
      @interest_payment = interest_payment
      @principal_payment = principal_payment
      @payment_amount = payment_amount
    end
    
    ActiveRecord::Base.transaction do 
      #money is going to pay this account transaction
      @withdrawal_to_transaction = Transaction.create!(
        amount: @total_payment_from_acc, #on mortgage this is to principal
        date: ocurred_on, 
        transaction_type: "Withdrawal", #payee account withdrawal
        comment: comment, 
        category: category, 
        payee: deposit_from_account_payee(from_account_id),
        interest_payment: @interest_payment,
        principal_payment: @principal_payment,  
        payment_amount: @payment_amount,
        account_id: to_account_id,
        transfer_ref: transfer_ref
      )

      #money is coming from this account transaction
      @withdrawal_transaction = Transaction.create!(
        amount: amount + payment_amount + principal_payment + interest_payment, 
        date: ocurred_on, 
        transaction_type: "Withdrawal",
        comment: comment, 
        category: category, 
        payee: withdrawal_to_account_payee(to_account_id),  
        interest_payment: 0,
        principal_payment: 0,
        payment_amount: 0,
        account_id: from_account_id, 
        transfer_ref: @withdrawal_to_transaction.id
      )

      @withdrawal_to_transaction.update_attributes(transfer_ref: @withdrawal_transaction.id)
      [@withdrawal_transaction, @withdrawal_to_transaction]
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
    %w(Deposit Withdrawal Transfer Payment)
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

  def self.charge_category_list(user) #charge is deposit to liability account
    [
      ['Expense', user.categories.where(category_type: 'Expense').order('LOWER(name)').map {|category| category.name.to_s }]
    ]
  end

  def self.payment_category_list(user) #payment is withdrawal from liability account
    [
      ['Income', user.categories.where(category_type: 'Income').order('LOWER(name)').map {|category| category.name.to_s }]
    ]
  end

  def self.transfer_category_list
    [
      ['Transfer', ['Other-Transfer']]
    ]
  end 

  def self.payment_category_list
    [
      ['Payment', ['Bill-Payment']]
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


  def calculate_mortgage_principal_interest_payment
    if self.created_at == nil # run if transaction has not been created yet (don't run on edit action)
      if self.transfer_ref == nil #run if not updating after self.payment block calls update 

        if self.account.type == 'Mortgage' && self.transaction_type == 'Withdrawal'
          @additional_interest = self.interest_payment
          @additional_principal = self.principal_payment

          self.amount = mortgage_payment_to_principal(self, self.payment_amount-self.account.minimum_escrow_payment)
          self.principal_payment = self.amount
          self.interest_payment = mortgage_payment_to_interest(self, self.payment_amount-self.account.minimum_escrow_payment)
          self.payment_amount = (self.payment_amount + @additional_interest + @additional_principal)
          self.interest_payment
        end 
      end
    end
  end

  def account_total(account_id)
    Transaction.where(account_id: account_id).map {|transaction| transaction.applied_amount}.sum
  end

  def mortgage_payment_to_principal(transaction, payment)
    # term = case transaction.account.term
    #   when "30yr" then 30*12
    #   when "20yr" then 20*12
    #   when "15yr" then 15*12
    #   else "Error"
    # end

    rate = transaction.account.interest_rate.to_f
    monthly_rate = rate / 12
    interest_payment = monthly_rate * account_total(transaction.account.id)
    principal_payment = (payment - (interest_payment/100)) + @additional_principal
  end

  def mortgage_payment_to_interest(transaction, payment)
    rate = transaction.account.interest_rate.to_f
    monthly_rate = rate / 12
    interest_payment = ((monthly_rate * account_total(transaction.account.id))/100) + @additional_interest
  end

  def self.calculate_mortgage_principal_interest_payment_two(amount, payment_amount, interest_payment, principal_payment)
    amount = mortgage_payment_to_principal_two(@mortgage_account, (amount-@mortgage_account.minimum_escrow_payment.to_f))
    @principal_payment = amount
    @interest_payment = mortgage_payment_to_interest_two(@mortgage_account, amount-@mortgage_account.minimum_escrow_payment.to_f)
  end

  def self.account_total_two(account_id)
    Transaction.where(account_id: account_id).map {|transaction| transaction.applied_amount}.sum
  end

  def self.mortgage_payment_to_principal_two(transaction_account, payment)
    rate = transaction_account.interest_rate.to_f
    monthly_rate = rate / 12
    @interest_payment = monthly_rate * account_total_two(@mortgage_account.id)
    @principal_payment = (payment - (@interest_payment.to_f/100))
    @payment_amount = @principal_payment
    @principal_payment
  end

  def self.mortgage_payment_to_interest_two(transaction, payment)
    rate = @mortgage_account.interest_rate.to_f
    monthly_rate = rate / 12
    interest_payment = ((monthly_rate * account_total_two(@mortgage_account.id))/100).to_f
  end

  def calculate_liability_payment_amount
    if self.transaction_type == "Withdrawal" && self.account.class.superclass.name == "Liability"
      if self.account.type != 'Mortgage'
        self.amount = (self.account.minimum_payment || 0) + self.payment_amount
      end
    end
  end

end