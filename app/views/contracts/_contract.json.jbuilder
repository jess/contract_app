json.extract! contract, :id, :content, :created_at, :updated_at, :name, :custom_fields, :is_sharing
json.url contract_url(contract, format: :json)
if contract.is_sharing? && contract.share_token.present?
  json.share_url share_url(contract.share_token)
end
