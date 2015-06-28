class Account < ActiveRecord::Base
  has_many :transactions, dependent: :destroy
  # above line is to destroy all transactions when account is deleted (dependent: :destroy)
  monetize :balance_cents

  after_create :opening_deposit_transaction

  #gives me access to helpers outside the view when account_details method is called
  #need to handle this better. affects line 1 in transactions/new.html.erb
  def get_helpers
    ActionController::Base.helpers
  end

  #custom collection select name for account transfer select menu
  def account_details
    "#{name} #{last4} (#{type}) #{get_helpers.number_to_currency(balance)}"
  end

  def self.types
    Asset.types.merge(Liability.types)
  end

  def self.types_fields
    types.inject({}) do |output_hash, name_type_pair| 
      output_hash.merge(name_type_pair.last.name => name_type_pair.last.new.fields)
    end
  end

  def fields
    #for editing fields for account edit. Shows fields in order typed below.
    %w(type status favorite name balance)
  end

  def balance
    self.transactions.map {|transaction| transaction.applied_amount}.sum
  end

  def opening_deposit_transaction
    Transaction.create!(
      amount: balance_cents / 100.00,
      account_id: self.id,
      transaction_type: 'Deposit',
      payee: 'Opening Deposit',
      category: 'Opening Deposit',
      comment: 'Opening Deposit',
      date: DateTime.now
    )
  end
end
