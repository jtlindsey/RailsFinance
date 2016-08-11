# json.array!(@transactions) do |transaction|
#   json.extract! transaction, :id, :date, :comment, :amount
#   json.url transaction_url(transaction, format: :json)
# end
json.transactions @transactions do |var|
	json.id var.id
	json.account_id var.account_id
	json.date var.date
	json.payee var.payee
	json.category var.category
	json.comment var.comment
	json.transfer_ref var.transfer_ref
	json.payee var.payee
	json.payee var.payee
	json.check_number var.check_number
	json.amount_cents var.amount_cents
	json.transaction_type var.transaction_type
	json.interest_payment_cents	var.interest_payment_cents 
	json.principal_payment_cents var.principal_payment_cents
	json.payment_amount_cents var.payment_amount_cents  
end

