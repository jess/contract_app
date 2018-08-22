class AddSharingToContracts < ActiveRecord::Migration[5.2]
  def change
    add_column :contracts, :share_token, :string
    add_index :contracts, :share_token
    add_column :contracts, :is_sharing, :boolean
  end
end
