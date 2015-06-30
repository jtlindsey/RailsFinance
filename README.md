## Personal Finance and Budgeting Software

I've been using Microsoft Money for 10+ years but it's always been a pain that it is only available on Windows OS. Now that I primarily use Mac and Linux, I'd like to have something just as useful but cross platform compatible. Plus I'd like to be able to use it on mobile devices. There are many paid services that already offer this, but I wanted to make a free open source version. I'll try to update this readme as parts of the project are completed. Currently I don't have a lot of time to commit to the project, so progress may be slow.

The software will be easy to use so people of all ages can use it to manage their personal or family finances and children can use it to learn how to budget and save.

Id like the desktop version of this to be based on the Node.js platform and be written in HTML, JavaScript, and CSS. That will be the next step after completing the Rails version. This feature list is primarily for the web version.

## Features Planned 
- [ ] =incomplete 
- [x] =complete

### Priority 1 Features
- [x] Create database schema design plan using mysql workbench http://www.mysql.com/products/workbench/
- [x] Account create, edit, delete
- [x] Transaction(deposit, withdrawal) create, edit, delete
- [x] Transaction(transfer) create, and delete(as block action)
- [x] Mobile friendly tables using single column mode when on phones
- [x] Implement bootstrap
- [x] Category create, edit, delete (Inceme and Expense Categories)
- [x] Budget create, edit, delete
- [ ] Transaction(transfer) edit(as one block action)
- [ ] Credit Cards, Loans, etc (Balance, Limit, Interest rage, and ability to sort by order should be paid off for lowest total interest paid)
- [ ] Calculate Mortgage Payments
- [ ] Track mortgage (fixed) with and without escrow
- [ ] Handle Escrow (P&I, Taxes, Insurance, and PMI or other additions)
- [ ] User create, edit, delete
- [ ] Setup multi-tenancy structure without using gem
- [ ] Consider using Ransack alone instead of activeadmin gem for search query forms
- [ ] Consider using activeadmin gem
- [ ] Home page with overview and profile summary
- [ ] Implement pie and bar charts using chartkick.com or charts.js
- [ ] Cross platform compatible with Windows, Mac, Linux, iOS, Android OS (test on all)
- [ ] Resize Text
- [x] Sort Transactions by category (Date, Check#, Description/memo, Category, Payment, Deposit, Balance)
- [ ] Create query page for multiple types of querys (spending, income, expenses, by payee, by category, )
- [ ] Add graph options to query page
- [ ] Print as pdf (custom print.css)
- [ ] Export to .txt and .csv file
- [ ] Export transactions to excel
- [ ] Add files to transactions (receipts as image or pdf, clicking on view transaction shows receipt preview and allows download of reciept copy)
- [ ] Database backup
- [ ] Update software without loosing existing data
- [ ] Budgeting, test integration and tracking with categories accounts
- [ ] Graphs..bar and pie and list (quick view change of expenses for week, month, quarter, 6-months, year)
- [ ] Graphs for others by link to page to create
- [ ] Graphs printable
- [ ] Net-worth tracking
- [ ] Create Getting Started Guide (Easy Quick Start Guide)
- [ ] Create User Guide with screen shots
- [ ] Create Getting started video
- [ ] Create feature video

### Priority 2 Features
- [ ] 4 Color theme options via settings in user accounts page for each user
- [ ] Goal to purchase / saving progress page
- [ ] Built in loan comparison calculators
- [ ] Produce Amortization Charts
- [ ] User accounts
- [ ] Support ticket location for easy submission and tracking
- [ ] Desktop / Web app sync
- [ ] Home page view grouping...(that can be changed by drag and drop?)

### Paid Version
The following features might be released in a paid version if not in the free open source version.

- [ ] Investment Accounts
- [ ] Stocks (static)
- [ ] Bonds (static)
- [ ] IRAs (static)


### Concerns
I will be learning along the way, using whatever tools I can find. In the end I hope to provide an easy to maintain application with readable code.

Support for users will be limited for the free version for now.