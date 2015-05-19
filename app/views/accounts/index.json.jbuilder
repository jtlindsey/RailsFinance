json.array!(@accounts) do |account|
  json.extract! account, :id, :type, :name, :last4, :status, :balance
  json.url account_url(account, format: :json)
end
