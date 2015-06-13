json.array!(@budget_items) do |budget_item|
  json.extract! budget_item, :id, :category, :amount, :period, :due_date
  json.url budget_item_url(budget_item, format: :json)
end
