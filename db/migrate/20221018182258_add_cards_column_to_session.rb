class AddCardsColumnToSession < ActiveRecord::Migration[6.1]
  def change
    add_column :sessions, :cards, :string
  end
end
