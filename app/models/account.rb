class Account < ActiveRecord::Base
  has_many :transactions
  monetize :balance_cents

  after_create :opening_deposit_transaction
  after_initialize :init

  def init
    #setting asset_liability column when account is created
    case type
    when 'Checking', 'Saving', 'Cash', 'Escrow', 'OtherAsset'
      self.asset_liability = 'Asset'
    when 'PersonalLoan', 'CreditCard', 'StudentLoan', 'OtherLiability', 'Mortgage'
      self.asset_liability = 'Liability' 
    end
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
    %w(type status name balance)
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
      comment: 'Opening Deposit',
      created_at: DateTime.now,
      updated_at: DateTime.now,
      date: DateTime.now
    )
  end
end
