class AddEmailColumntAccounts < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :email, :string
  end
end
