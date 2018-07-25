json.extract! contract, :id, :content, :created_at, :updated_at, :name, :custom_fields
json.url contract_url(contract, format: :json)
