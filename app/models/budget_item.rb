class BudgetItem < ActiveRecord::Base
  validates :category, inclusion: {in: Category.order(:name).map {|category| category.name}, message: 'has not been selected' }
  validates :period, inclusion: {in: %w(Weekly Bi-Weekly Monthly Quarterly Bi-Annually Yearly), message: 'has not been selected' }
    
  monetize :amount_cents

  def self.period_list
    #list of periods for form
    %w(Weekly Bi-Weekly Monthly Quarterly Bi-Annually Yearly)
  end

  def budget_spent(budget_item_period)
    case budget_item_period
    # when "Weekly"
      #
    # when "Bi-Weekly"
      #
    when "Monthly"
      Transaction.where(date: Time.now.beginning_of_month..Time.now.end_of_month).where(category: category).inject(0) {|output, transaction| output + transaction.amount}
    # when "Quarterly"
      #
    # when "Bi-Annually"
      #
    # when "Yearly"
      #
    end

    #Transaction.where(category: category).inject(0) {|output, transaction| output + transaction.amount}      
    #@budget_spent ||= Transaction.where(category: category).inject(0) {|output, transaction| output + transaction.amount}      
  end


end
