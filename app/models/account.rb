class Account < ActiveRecord::Base
  monetize :balance_cents

  def self.types
    Asset.types # + Liability.types
  end
end
