class Asset < Account
  validates :name, presence: true, length: {maximum: 45}
  validates :last4, presence: true, length: {is: 4}
  validates :status, inclusion: {in: ['Open', 'Closed']}

  def self.statuses
    ['Open', 'Closed']
  end

  def self.types
    ['Checking', 'Saving']
  end
end