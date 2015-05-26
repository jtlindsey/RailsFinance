class Asset < Account
  validates :name, presence: true, length: {maximum: 45}
  validates :last4, length: {maximum: 4}
  validates :status, inclusion: {in: ['Open', 'Closed']}

  def self.statuses
    ['Open', 'Closed']
  end

  def self.types
    {
      'Checkings' => Checking, 
      'Savings' => Saving,
      'Cash' => Cash,
      'Other Asset' => OtherAsset
    }
  end
end