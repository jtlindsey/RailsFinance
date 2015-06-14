class Category < ActiveRecord::Base
  validates :name, presence: true, length: {maximum: 30}
  validates :category_type, inclusion: {in: ['Income', 'Expense']}

  def self.category_types
    ['Income', 'Expense']
  end

end
