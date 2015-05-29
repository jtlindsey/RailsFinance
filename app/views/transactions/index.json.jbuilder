json.array!(@transactions) do |transaction|
  json.extract! transaction, :id, :date, :for, :comment, :amount
  json.url transaction_url(transaction, format: :json)
end
