# json.array!(@accounts) do |account|
#   json.extract! account, :id, :type, :name, :last4, :status, :balance
#   json.url account_url(account, format: :json)
# end

json.accounts @accounts do |var|
	json.user_id var.user_id
	json.id var.id
	json.type var.type
	json.name var.name
	json.last4 var.last4
	json.status var.status
	json.balance_cents var.balance_cents
	json.credit_limit var.credit_limit
	json.interest_rate var.interest_rate
	json.favorite var.favorite
	json.mortgage_term var.mortgage_term
	json.loan_amount_cents var.loan_amount_cents
	json.minimum_payment_cents var.minimum_payment_cents
	json.minimum_escrow_payment_cents var.minimum_escrow_payment_cents
end


