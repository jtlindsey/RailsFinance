class BudgetItem < ActiveRecord::Base
  belongs_to :user

  validates :budget_type, inclusion: {in: %w(Income Expense), message: 'has not been selected' }
  validate :is_users_category
  validates :period, inclusion: {in: %w(Weekly Bi-Weekly Monthly Quarterly Yearly), message: 'has not been selected' }

  monetize :amount_cents

  def is_users_category
    user = User.find(self.user_id)
    if user.categories.count > 0
      # byebug
      category_list = user.categories.map {|category| category.name}
      if category_list.include?(category) == false
        self.errors.add(:category, "has not been selected") 
      end
    else
      link = Rails.application.routes.url_helpers.categories_path
      self.errors.add(:category, "you must add categories first, go to options and click category.")
    end
  end

  def self.budget_type
    [
      'Income', 'Expense'
    ]
  end

  def self.period_list
    #list of periods for form
    %w(Weekly Bi-Weekly Monthly Quarterly Yearly)
  end

  def self.watch_expense_items(user)
    collection = user ? user.budget_items : self
    collection.where(budget_type: "Expense").where(watch: true).to_a.sort do |a,b|
      b.spent.to_f/b.amount_cents.to_f <=> a.spent.to_f/a.amount_cents.to_f
    end
  end  

  def self.watch_income_items(user)
    collection = user ? user.budget_items : self
    collection.where(budget_type: "Income").where(watch: true).to_a.sort do |a,b|
      b.gain.to_f/b.amount_cents.to_f <=> a.gain.to_f/a.amount_cents.to_f
    end
  end 

  def bi_week
    #week and bi-week start on monday and end on sunday
    case 
    when Date.today.cweek.odd?
      Date.commercial(Date.today.year, Date.today.cweek, 1)..Date.commercial(Date.today.year, Date.today.cweek+1, 7)
    when Date.today.cweek.even?
      Date.commercial(Date.today.year, Date.today.cweek-1, 1)..Date.commercial(Date.today.year, Date.today.cweek, 7)
    end
  end

  def spent
    budget_spent(period, user)
  end

  def gain
    budget_gain(period, user)
  end

  def budget_spent(budget_item_period, user)
    #byebug
    #TODO Refactor to avoid duplication of inject
    #Also look into having case statement set only the date because it's the only part that varies
    date = case budget_item_period
    when "Weekly"
      Date.today.at_beginning_of_week..Date.today.at_end_of_week
    when "Bi-Weekly"
      bi_week
    when "Monthly"
      Date.today.beginning_of_month..Date.today.end_of_month
    when "Quarterly"
      Date.today.at_beginning_of_quarter..Date.today.at_end_of_quarter
    when "Yearly"
      Date.today.at_beginning_of_year..Date.today.at_end_of_year
    end

    a = user.transactions.joins(:account).where(accounts: {type: Asset.types.values}).where(transaction_type: 'Withdrawal').where(date: date).where(category: category).inject(0) {|output, transaction| output + transaction.amount}
    b = user.transactions.where(transaction_type: 'Deposit').where(date: date).where(category: category).joins(:account).where(accounts: {type: Liability.types.values}).inject(0) {|output, transaction| output + transaction.amount}
    a+b
    #Transaction.where(category: category).inject(0) {|output, transaction| output + transaction.amount}      
    #@budget_spent ||= Transaction.where(category: category).inject(0) {|output, transaction| output + transaction.amount}      
  end

  def budget_gain(budget_item_period, user)
    date = case budget_item_period
    when "Weekly"
      Date.today.at_beginning_of_week..Date.today.at_end_of_week
    when "Bi-Weekly"
      bi_week
    when "Monthly"
      Date.today.beginning_of_month..Date.today.end_of_month
    when "Quarterly"
      Date.today.at_beginning_of_quarter..Date.today.at_end_of_quarter
    when "Yearly"
      Date.today.at_beginning_of_year..Date.today.at_end_of_year
    end

    a = user.transactions.joins(:account).where(accounts: {type: Asset.types.values}).where(transaction_type: 'Deposit').where(date: date).where(category: category).inject(0) {|output, transaction| output + transaction.amount}
    # b = user.transactions.where(transaction_type: 'Withdrawal').where(date: date).where(category: category).joins(:account).where(accounts: {type: Liability.types.values}).inject(0) {|output, transaction| output + transaction.amount}
    a    
  end


end
