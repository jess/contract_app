class AddCustomFieldsToContracts < ActiveRecord::Migration[5.2]
  def change
    add_column :contracts, :custom_fields, :json
  end
end
