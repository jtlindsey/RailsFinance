## Update 23 March 2016
To simplify application maintenance, inactive user accounts and user accounts with zero transaction accounts have been deleted. Existing users can still receive support through the contact page.

## Update 15 March 2016
This application is no longer being maintained. Time constraints have prevented me from being able to maintain the application properly. It will still be available yet on a slower economy server. Previously the app was hosted on a server I was paying for with cost increasing with usage. No new registrations will be allowed. Existing users can still receive support through the contact page.

I am building another application with a different approach. The current project is a desktop version available for Linux, Mac, Windows, ChromeOS using nw.js. After the desktop version is stable, a cloud database will be setup that will allow you to sync data across devices. When the project is at that point, this rails app will likely be taken down and re-built to support this functionality unless I decide to stick with js for the web version. 

For developers that followed this project for experimental and learning, you probably noticed how slow the database got after a few hundred transactions per account. If you haven't figured out the problem, you can contact me [here](http://jtlindsey.com/contact.html) to get help with dramatically speeding up database queries. The original database is configured very poorly and I've discovered some changes that can improve it for anybody interested. The changes that offer the biggest gain require a complete schema redesign along with many query and template changes which I haven't had time to do.

## Update May 2015
## Personal Finance and Budgeting Software

I've been using Microsoft Money for 10+ years but it's always been a pain that it is only available on Windows OS. Now that I primarily use Mac and Linux, I'd like to have something just as useful but cross platform compatible. Plus I'd like to be able to use it on mobile devices. There are many paid services that already offer this, but I wanted to make a free open source version. I'll try to update this readme as parts of the project are completed. Currently I don't have a lot of time to commit to the project, so progress may be slow.

Id like the desktop version of this to be based on the Node.js platform and be written in HTML, JavaScript, and CSS. That will be the next step after completing this Ruby on Rails version. This feature list is primarily for the web version.

## Key 
- [ ] =incomplete 
- [x] =complete


### Active-TODO
- [ ] Consider using Ransack alone instead of activeadmin gem for search query forms
- [ ] Consider using activeadmin gem
- [ ] Check browser Resize Text
- [ ] Cross platform compatible with Windows, Mac, Linux, iOS, Android OS (test on all)
- [ ] Create query page for multiple types of querys (spending, income, expenses, by payee, by category, )
- [ ] Add graph options to query page
- [ ] Update 'show' page for all account types to show all columns when looking at transactions
- [ ] Database backup
- [ ] Add HELP page
- [ ] Update FAQ page
- [ ] Create Getting Started Guide (Easy Quick Start Guide)
- [ ] Create Getting started video
- [ ] Create feature video


### Priority 1 Features
- [x] Postgresql database
- [x] Account create, edit, delete
- [x] Transaction(deposit, withdrawal) create, edit, delete
- [x] Transaction(transfer) create, and delete(as block action)
- [x] Mobile friendly tables using single column mode when on phones
- [x] Bootstrap it
- [x] Category create, edit, delete (Inceme and Expense Categories)
- [x] Budget create, edit, delete
- [x] Pie and bar charts using chartkick.com or charts.js on home page
- [x] Sort Transactions by category (Date, Check#, Description/memo, Category, Payment, Deposit, Balance)
- [x] User create, edit, delete
- [x] Track mortgage (fixed) with and without escrow
- [x] Handle Escrow (P&I, Taxes, Insurance, and PMI or other additions)
- [x] Home page with overview and profile summary
- [x] Net-worth tracking
- [x] Add files to transactions (receipts as image or pdf, clicking on view transaction shows receipt titles and allows download of reciept)
- [x] Update software without loosing existing data
- [ ] Transaction(transfer) edit(as one block action)
- [ ] Credit Cards, Loans, etc (Balance, Limit, Interest rate, and ability to sort by order should be paid off for lowest total interest paid)
- [ ] Print as pdf (custom print.css)
- [ ] Click budget to view all transactions for that budget category and period
- [ ] Graphs printable


### Priority 2 Features
- [ ] 4 Color theme options via settings in user accounts page for each user
- [ ] Export to .txt and .csv file
- [ ] Export transactions to excel
- [ ] Goal to purchase / saving progress page
- [ ] Built in loan comparison calculators
- [ ] Produce Amortization Charts
- [ ] Graphs..bar and pie and list options(quick view change of expenses for week, month, quarter, 6-months, year)
- [ ] Create pdf User Guide with screen shots
- [ ] Support ticket location for easy submission and tracking
- [ ] Desktop / Web app sync
- [ ] Investment Accounts
- [ ] Stocks (static)
- [ ] Bonds (static)
- [ ] IRAs (static)


### Concerns
I will be learning along the way, using whatever tools I can find. In the end I hope to provide an easy to maintain application with readable code.


## Pics from Demo Account

New Account with no accounts.

![alt text](https://raw.githubusercontent.com/jtlindsey/DemoPics/master/MyMoneyOTG_Rails/1_new.png "New account")

Account with activity.

![alt text](https://raw.githubusercontent.com/jtlindsey/DemoPics/master/MyMoneyOTG_Rails/1_new_1.png "Account with activity")

Options page.

![alt text](https://raw.githubusercontent.com/jtlindsey/DemoPics/master/MyMoneyOTG_Rails/2_options.png "Options")

Budget.

![alt text](https://raw.githubusercontent.com/jtlindsey/DemoPics/master/MyMoneyOTG_Rails/3_budget_1.png "Budget")

![alt text](https://raw.githubusercontent.com/jtlindsey/DemoPics/master/MyMoneyOTG_Rails/3_budget_2.png "Budget")

![alt text](https://raw.githubusercontent.com/jtlindsey/DemoPics/master/MyMoneyOTG_Rails/3_budget_3.png "Budget")

![alt text](https://raw.githubusercontent.com/jtlindsey/DemoPics/master/MyMoneyOTG_Rails/3_budget_4.png "Budget")

All Accounts

![alt text](https://raw.githubusercontent.com/jtlindsey/DemoPics/master/MyMoneyOTG_Rails/4_all_accounts1.png "All A")

![alt text](https://raw.githubusercontent.com/jtlindsey/DemoPics/master/MyMoneyOTG_Rails/4_all_accounts2.png "All A")

Edit Account

![alt text](https://raw.githubusercontent.com/jtlindsey/DemoPics/master/MyMoneyOTG_Rails/5_edit_account1.png "Edit A")

New Account

![alt text](https://raw.githubusercontent.com/jtlindsey/DemoPics/master/MyMoneyOTG_Rails/5_new_account1.png "Account")

![alt text](https://raw.githubusercontent.com/jtlindsey/DemoPics/master/MyMoneyOTG_Rails/5_new_account2.png "Account")

![alt text](https://raw.githubusercontent.com/jtlindsey/DemoPics/master/MyMoneyOTG_Rails/5_new_account3.png "Account")

![alt text](https://raw.githubusercontent.com/jtlindsey/DemoPics/master/MyMoneyOTG_Rails/5_new_account4.png "Account")

Transactions

![alt text](https://raw.githubusercontent.com/jtlindsey/DemoPics/master/MyMoneyOTG_Rails/8_some_transactions.png "Transactions")

Financial Summary

![alt text](https://raw.githubusercontent.com/jtlindsey/DemoPics/master/MyMoneyOTG_Rails/9_financial_summary1.png "Financial Summary")

![alt text](https://raw.githubusercontent.com/jtlindsey/DemoPics/master/MyMoneyOTG_Rails/9_financial_summary2.png "Financial Summary")

Contact

![alt text](https://raw.githubusercontent.com/jtlindsey/DemoPics/master/MyMoneyOTG_Rails/6_contact.png "Contact")

FAQ

![alt text](https://raw.githubusercontent.com/jtlindsey/DemoPics/master/MyMoneyOTG_Rails/7_faq.png "FAQ")

![alt text](https://raw.githubusercontent.com/jtlindsey/DemoPics/master/MyMoneyOTG_Rails/7_faq2.png "FAQ")

Admin View  

Shows multiple tracking options that can be used to integrate additional security parameters for account access.

![alt text](https://raw.githubusercontent.com/jtlindsey/DemoPics/master/MyMoneyOTG_Rails/10_admin1.png "admin")

![alt text](https://raw.githubusercontent.com/jtlindsey/DemoPics/master/MyMoneyOTG_Rails/10_admin2.png "admin")

![alt text](https://raw.githubusercontent.com/jtlindsey/DemoPics/master/MyMoneyOTG_Rails/10_admin3.png "admin")
<br>

## Site is online at:

[View app live](http://www.mymoneyonthego.com/)
