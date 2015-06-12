class Checking < Asset
  def fields
    # not working for edit, only working for new account
    super + %w(last4)
  end
end