class CreateFlashcardsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :flashcards do |t|
      t.belongs_to :topic
      t.string :front 
      t.string :back 
      t.integer :views 
      t.integer :difficulty
      t.timestamps
    end 
  end
end
