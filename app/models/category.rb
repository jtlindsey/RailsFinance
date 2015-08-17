class Category < ActiveRecord::Base
  belongs_to :user
  
  validates :name, presence: true, length: {maximum: 30}
  validates_format_of :name, with: /\A[\sa-z \-'\ :]+\Z/i, message: 'can only contain letters, spaces and the following special characters - and :'
  validates :category_type, inclusion: {in: ['Income', 'Expense']}

  def self.category_types
    ['Income', 'Expense']
  end

end
