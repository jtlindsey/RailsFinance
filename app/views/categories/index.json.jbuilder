# json.array!(@categories) do |category|
#   json.extract! category, :id, :category_type, :name
#   json.url category_url(category, format: :json)
# end

json.categories @categories do |var|
	json.user_id var.user_id
	json.id var.id
	json.category_type var.category_type
	json.name var.name
end