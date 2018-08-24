class AddSignatureToContracts < ActiveRecord::Migration[5.2]
  def change
    add_column :contracts, :signature, :string
    add_column :contracts, :signer_name, :string
  end
end
