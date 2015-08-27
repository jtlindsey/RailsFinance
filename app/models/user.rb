class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  has_many :accounts, dependent: :destroy
  has_many :transactions, through: :accounts
  has_many :budget_items, dependent: :destroy
  has_many :categories, dependent: :destroy

  validates :name, presence: true, length: {maximum: 20}
  validates_format_of :name, with: /\A[\sa-z0-9]+\Z/i, message: 'can only contain numbers and letters'

  after_create :create_transaction_categories_for_user


  def create_transaction_categories_for_user
    # create starter categories for new users
    user_id = self.id
    Category.create!([
      { user_id: user_id, category_type: 'Expense', name: 'Food-Grocery'},
      { user_id: user_id, category_type: 'Expense', name: 'Food-Eatout'}, 
      { user_id: user_id, category_type: 'Expense', name: 'Automotive-Maintenance'},
      { user_id: user_id, category_type: 'Expense', name: 'Automotive-Gas'},
      { user_id: user_id, category_type: 'Expense', name: 'Automotive-Insurance'},
      { user_id: user_id, category_type: 'Expense', name: 'Bank-Fees'},
      { user_id: user_id, category_type: 'Expense', name: 'Utilities-Electric'},
      { user_id: user_id, category_type: 'Expense', name: 'Utilities-Water'},
      { user_id: user_id, category_type: 'Expense', name: 'Utilities-Gas'},
      { user_id: user_id, category_type: 'Expense', name: 'Yard-Maintenance'},
      { user_id: user_id, category_type: 'Expense', name: 'Phone'},
      { user_id: user_id, category_type: 'Expense', name: 'Education'},
      { user_id: user_id, category_type: 'Expense', name: 'Other'},
      { user_id: user_id, category_type: 'Income', name: 'PrimaryJob'},
      { user_id: user_id, category_type: 'Income', name: 'Bank-Interest'},
      { user_id: user_id, category_type: 'Income', name: 'Other-Income'},
      { user_id: user_id, category_type: 'Income', name: 'Opening-Deposit'}    
    ])
  end

end
