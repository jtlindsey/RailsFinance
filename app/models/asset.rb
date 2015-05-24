class Asset < Account
  validates :name, presence: true, length: {maximum: 45}
  validates :last4, presence: true, length: {is: 4}
  validates :status, inclusion: {in: ['Open', 'Closed']}

  def self.statuses
    ['Open', 'Closed']
  end

  def self.types
    # jtl this structure doesn't set me up to easily create user friendly drop down titles
    # for examples if I want to say "Other Asset" i can't have that space without changing
    # this method
    # stuck with error after playing with this
    # ActiveRecord::SubclassNotFound in Accounts#index
    # The single-table inheritance mechanism failed to locate the subclass: 'Other
    # line 16 on index page flagged
    # ['Checking', 'Saving']

    #attempted solution
    {
      'A Checking' => Checking, 
      'A Saving' => Saving
    }
  end
end