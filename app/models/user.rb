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
end
