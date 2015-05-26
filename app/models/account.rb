class Account < ActiveRecord::Base
  monetize :balance_cents
  
  def self.types
    Asset.types.merge(Liability.types)
  end

end
