class AddOmniauthToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :googleid, :string
    add_column :users, :facebookid, :string
  end
end
