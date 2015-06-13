json.array!(@budgets) do |budget|
  json.extract! budget, :id, :category, :amount, :period, :due_date
  json.url budget_url(budget, format: :json)
end
