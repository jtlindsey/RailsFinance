class CreditCard < Liability
  def fields
    super + %w(last4 credit_limit interest_rate minimum_payment)
  end
end