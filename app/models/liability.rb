class Liability < Account
  validates :name, presence: true, length: {maximum: 45}
  validates :last4, length: {maximum: 4}
  validates :status, inclusion: {in: ['Open', 'Closed']}

  class << self # Class methods grouped here
    def statuses
      ['Open', 'Closed']
    end

    def types
      {
        'Personal Loan' => PersonalLoan, 
        'Credit Card' => CreditCard,
        'Student Loan' => StudentLoan,
        'Other Liability' => OtherLiability,
        'Mortgage (fixed)' => Mortgage
      }
    end
    # User liability display
    def account_type_groups
      types.values.sort_by(&:name)
    end

    def for_user(user) # for account_type_group partial collection
      where(user_id: user.id).order('LOWER(name)')
    end

    def liabilities_total(user)
      Money.new(where(user_id: user.id).sum(:balance_cents))
    end

    def total_balance_for_account_type(user)
      total_all = 0
      where(user_id: user.id).each do 
        |x| total_all += x.transactions.map {|transaction| transaction.applied_amount}.sum
      end
      total_all
    end
    # User liability display end
  end
  # Instance methods follow here
end