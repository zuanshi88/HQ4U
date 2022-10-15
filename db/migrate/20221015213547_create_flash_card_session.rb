class CreateFlashCardSession < ActiveRecord::Migration[6.1]
  def change
        create_table :flashcards_session do |t| 
      t.integer :number 
      t.string :difficulty 
      t.string :views
      t.timestamps 
    end 
  end
end
