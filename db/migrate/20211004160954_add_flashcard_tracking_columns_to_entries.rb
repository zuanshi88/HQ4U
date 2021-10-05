class AddFlashcardTrackingColumnsToEntries < ActiveRecord::Migration[6.1]
  def change
    add_column :entries, :views, :integer, default: 0
    add_column :entries, :difficulty, :integer, default: 10
  end
end
