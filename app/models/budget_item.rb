class BudgetItem < ActiveRecord::Base
  validates :category, inclusion: {in: Category.order(:name).map {|category| category.name}, message: 'has not been selected' }
  validates :period, inclusion: {in: %w(Weekly Monthly Quarterly Bi-Annually Yearly), message: 'has not been selected' }
    
  monetize :amount_cents

  def self.period_list
    #list of periods for form
    %w(Weekly Monthly Quarterly Bi-Annually Yearly)
  end

  def budget_spent
    @budget_spent ||= Transaction.where(category: category).inject(0) {|output, transaction| output + transaction.amount}      
  end

  # def self.budget_progress_show
  #   budget_progress = 0
  #   Transaction.where(category: 'Automotive-Gas').each {|transaction| budget_progress += transaction.amount}
  #   budget_progress
  # end

  # def testing_querys
  #   #Account.joins(:transactions).where(transactions: {category: 'Automotive-Gas'}).count
  #   #Transaction.where(category: 'Automotive-Gas').count
  #   #Transaction.where(category: 'Automotive-Gas').each {|transaction| @test += transaction.amount}
  # end
end
