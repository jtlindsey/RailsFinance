class Account < ActiveRecord::Base
  has_many :transactions, dependent: :destroy
  # above line is to destroy all transactions when account is deleted (dependent: :destroy)
  monetize :balance_cents

  after_create :opening_deposit_transaction

  #gives me access to helpers outside the view when account_details method is called
  #need to handle this better. affects line 1 in transactions/new.html.erb
  #being used in _transfer collection select method
  def get_helpers
    ActionController::Base.helpers
    #change to this or translation?... ApplicationController.helpers
  end
  #next line being used with spending_by_category method in this model, need to refactor above and below
  def self.get_helpers2
    ActionController::Base.helpers
    #change to this or translation? ApplicationController.helpers
  end

  #custom collection select name for account transfer select menu
  def account_details
    "#{name} #{last4} (#{type}) #{get_helpers.number_to_currency(balance)}"
  end

  def self.spending_query(category)
    Transaction.order(:category).where(transaction_type: 'Withdrawal').where(category: category.name).inject(0) {|output, transaction| output + transaction.amount}
  end

  def self.convert_money_to_number(money)
    #had to convert money to number for use with googlecharts spending by category
    money.to_s.gsub(/[$,]/,'').to_f
  end

  # def self.spending_by_category_google_charts
  #   @category_names = []
  #   @category_totals = []
  #   Category.order(:name).where(category_type: 'Expense').each do |category|
  #       @category_totals.push(convert_money_to_number(spending_query(category)))
  #       @category_names.push("#{category.name} #{get_helpers2.number_to_currency(spending_query(category))}" )
  #   end

  #   Gchart.pie_3d(:size => '650x250', :data => @category_totals, :labels => @category_names )
  # end

  def self.spending_by_category_chartkick(user)
    @category_names = []
    @category_totals = []
    # category_collection = user ? user.categories : Category
    user.categories.order(:name).where(category_type: 'Expense').each do |category|
        @category_totals.push(convert_money_to_number(spending_query_by_month(category)))
        @category_names.push("#{category.name} #{get_helpers2.number_to_currency(spending_query(category))}" )
    end

    @spending = Hash[@category_names.zip @category_totals]
  end

  def self.spending_query_by_month(category)
    Transaction.order(:category).where(transaction_type: 'Withdrawal').where(date: Date.today.beginning_of_month..Date.today.end_of_month).where(category: category.name).inject(0) {|output, transaction| output + transaction.amount}
  end

  # def self.networth
  #   @assets_list = Account.order('LOWER(name)').where(type: Asset.types.values)
  #   @liabilities_list = Account.order('LOWER(name)').where(type: Liability.types.values)

  #   @assets_total = 0
  #   @assets_list.each {|asset| @assets_total += asset.balance }

  #   @liabilities_total = 0
  #   @liabilities_list.each {|liability| @liabilities_total += liability.balance }

  #   [
  #     ["Assets", convert_money_to_number(@assets_total)], 
  #     ["Liabilities", convert_money_to_number(@liabilities_total)]
  #   ]
  # end


#alternate for networth bar chart
  def self.user_networth(user)
    # account_collection = user ? user.accounts : self
    a = user.accounts.where(type: Asset.types.values).inject(0) { |sum, account| sum + account.balance }
    l = user.accounts.where(type: Liability.types.values).inject(0) { |sum, account| sum + account.balance }
    a - l
  end

  def self.assets
    @assets_list = Account.where(type: Asset.types.values)
    @assets_total = 0
    @assets_list.each {|asset| @assets_total += asset.balance }

    convert_money_to_number(@assets_total)
  end
  def self.liabilities
    @liabilities_list = Account.where(type: Liability.types.values)
    @liabilities_total = 0
    @liabilities_list.each {|liability| @liabilities_total += liability.balance }
    
    convert_money_to_number(@liabilities_total)
  end
#end alternate

  def self.types
    Asset.types.merge(Liability.types)
  end

  def self.types_fields
    types.inject({}) do |output_hash, name_type_pair| 
      output_hash.merge(name_type_pair.last.name => name_type_pair.last.new.fields)
    end
  end

  def fields
    #for editing fields for account edit. Shows fields in order typed below.
    %w(type status favorite name balance)
  end

  def balance
    self.transactions.map {|transaction| transaction.applied_amount}.sum
  end

  def opening_deposit_transaction
    Transaction.create!(
      amount: balance_cents / 100.00,
      account_id: self.id,
      transaction_type: 'Deposit',
      payee: 'Opening Deposit',
      category: 'Opening Deposit',
      comment: 'Opening Deposit',
      date: DateTime.now
    )
  end
end
