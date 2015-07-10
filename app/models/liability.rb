class Liability < Account
  validates :name, presence: true, length: {maximum: 45}
  validates :last4, length: {maximum: 4}
  validates :status, inclusion: {in: ['Open', 'Closed']}

  # Class methods grouped here
  class << self
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

    def account_type_groups
      types.values.sort_by(&:name)
    end

    def total
      Money.new(all.sum(:balance_cents))
    end
  end

  # Instance methods follow here
end