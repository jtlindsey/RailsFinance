class Mortgage < Liability
  def fields
    super + %w(last4 mortgage_term loan_amount minimum_payment minimum_escrow_payment)
  end
end