class BudgetItem < ActiveRecord::Base
  validates :category, inclusion: {in: Category.order(:name).map {|category| category.name}, message: 'has not been selected' }
  validates :period, inclusion: {in: %w(Weekly Bi-Weekly Monthly Quarterly Yearly), message: 'has not been selected' }
    
  monetize :amount_cents

  def self.period_list
    #list of periods for form
    %w(Weekly Bi-Weekly Monthly Quarterly Yearly)
  end

  def self.watch_items(user=nil)
    collection = user ? user.budget_items : self
    collection.where(watch: true).to_a.sort do |a,b|
      b.spent.to_f/b.amount_cents.to_f <=> a.spent.to_f/a.amount_cents.to_f
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
    budget_spent(period)
  end

  def budget_spent(budget_item_period)
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
    Transaction.where(date: date).where(category: category).inject(0) {|output, transaction| output + transaction.amount}

    #Transaction.where(category: category).inject(0) {|output, transaction| output + transaction.amount}      
    #@budget_spent ||= Transaction.where(category: category).inject(0) {|output, transaction| output + transaction.amount}      
  end

end
