json.array!(@categories) do |category|
  json.extract! category, :id, :category_type, :name
  json.url category_url(category, format: :json)
end
