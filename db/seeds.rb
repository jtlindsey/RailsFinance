# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#put category first in seed so account create dosent fail on after create action
categories = Category.create([
  { category_type: 'Expense', name: 'Food-Grocery'},
  { category_type: 'Expense', name: 'Food-Eatout'}, 
  { category_type: 'Expense', name: 'Automotive-Maintenance'},
  { category_type: 'Expense', name: 'Automotive-Gas'},
  { category_type: 'Expense', name: 'Bank-Fees'},
  { category_type: 'Expense', name: 'Utilities-Electric'},
  { category_type: 'Expense', name: 'Utilities-Water'},
  { category_type: 'Expense', name: 'Utilities-Gas'},
  { category_type: 'Expense', name: 'Telephone'},
  { category_type: 'Income', name: 'PrimaryJob'},
  { category_type: 'Income', name: 'OtherIncome'},
  { category_type: 'Income', name: 'Opening Deposit'}    
])

