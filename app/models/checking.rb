class Checking < Asset
  def fields
    super + %w(last4)
  end
end