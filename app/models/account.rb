class Account < ActiveRecord::Base
  monetize :balance_cents
end
