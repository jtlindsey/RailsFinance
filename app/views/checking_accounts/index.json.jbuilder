json.array!(@checking_accounts) do |checking_account|
  json.extract! checking_account, :id, :name, :last4, :status, :balance
  json.url checking_account_url(checking_account, format: :json)
end
