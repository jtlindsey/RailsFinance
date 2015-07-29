json.array!(@documents) do |document|
  json.extract! document, :id, :efile
  json.url document_url(document, format: :json)
end
