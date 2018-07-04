class CreateUserContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :user_contracts do |t|
      t.references :user, foreign_key: true
      t.references :contract, foreign_key: true

      t.timestamps
    end
  end
end
