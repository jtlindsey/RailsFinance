class BudgetItem < ActiveRecord::Base
    monetize :amount_cents
end
