class Liability < Account
  validates :name, presence: true, length: {maximum: 45}
  validates :last4, length: {maximum: 4}
  validates :status, inclusion: {in: ['Open', 'Closed']}

  def self.statuses
    ['Open', 'Closed']
  end

  def self.types
    {
      'Personal Loan' => PersonalLoan, 
      'Credit Card' => CreditCard,
      'Student Loan' => StudentLoan,
      'Other Liability' => OtherLiability,
      'Mortgage (fixed)' => Mortgage
    }
  end
end