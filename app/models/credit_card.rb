class CreditCard < Liability
  def fields
    # not working for edit, only working for new account
    super + %w(last4 credit_limit interest_rate)
  end
end