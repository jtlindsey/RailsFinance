class Account < ActiveRecord::Base
  has_many :transactions
  monetize :balance_cents
  
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

  # TODO today we calculate balance dynamically. 
  # Evaluate if we should remove balance setting
  # from the account creation wizard/edit given it is derived from all transactions
  # Alternatively, rename balance to "known_balance"

end
