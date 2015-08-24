class Checking < Asset
  def fields
    super + %w(last4 check_number)
  end
end