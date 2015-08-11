class StudentLoan < Liability
  def fields
    super + %w(last4 loan_amount interest_rate minimum_payment)
  end
end