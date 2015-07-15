class Asset < Account
  validates :name, presence: true, length: {maximum: 45}
  validates :last4, length: {maximum: 4}
  validates :status, inclusion: {in: ['Open', 'Closed']}

  class << self
    def statuses #self.statuses
      ['Open', 'Closed']
    end

    def types #self.types
      {
        'Checkings' => Checking, 
        'Savings' => Saving,
        'Cash' => Cash,
        'Escrow' => Escrow,
        'Other Asset' => OtherAsset
      }
    end
    # User assets display
    def account_type_groups
      types.values.sort_by(&:name)
    end

    def for_user(user) # for account_type_group partial collection
      where(user_id: user.id).order('LOWER(name)')
    end

    def assets_total(user)
      Money.new(where(user_id: user.id).sum(:balance_cents))
    end

    def total_balance_for_account_type(user)
      total_all = 0
      where(user_id: user.id).each do 
        |x| total_all += x.transactions.map {|transaction| transaction.applied_amount}.sum
      end
      total_all
    end
    # User assets display end
  end
  # Instance methods follow here
end