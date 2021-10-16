class AddForeignKeysToNotesTable < ActiveRecord::Migration[6.1]
  def change
    add_reference :notes, :book 
    add_reference :notes, :quote
  end
end
