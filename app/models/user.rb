class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :accounts, dependent: :destroy
  has_many :transactions, through: :accounts
  has_many :budget_items, dependent: :destroy
  has_many :categories, dependent: :destroy
end
