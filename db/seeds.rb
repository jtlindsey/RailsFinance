# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
accounts = Account.create([
  { type: 'Checking', name: 'BOA seed', last4: '0214', balance: 2765.81}, 
  { type: 'Saving', name: 'BOA seed', last4: '5214', balance: 473.00},
  { type: 'Cash', name: 'MyCash seed', balance: 684.87},
  { type: 'Escrow', name: 'WellsFargo seed', last4: '4321', balance: 3473.00},
  { type: 'OtherAsset', name: 'Loan to Kate seed', balance: 500.00},
  { type: 'CreditCard', name: 'Citi-Master seed', last4: '6384', balance: 2500.00},
  { type: 'StudentLoan', name: 'Nelnet seed', balance: 5588.00},
  { type: 'PersonalLoan', name: 'PNC seed', last4: '8465', balance: 1500.74},
  { type: 'OtherLiability', name: 'Loan From Jim seed', balance: 942.58}
  ])
