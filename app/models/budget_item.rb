class BudgetItem < ActiveRecord::Base
  validates :category, inclusion: {in: Category.order(:name).map {|category| category.name}, message: 'has not been selected' }
  validates :period, inclusion: {in: %w(Weekly Monthly Quarterly Bi-Annually Yearly), message: 'has not been selected' }
    
  monetize :amount_cents

  def self.period_list
    #list of periods for form
    %w(Weekly Monthly Quarterly Bi-Annually Yearly)
  end
end
