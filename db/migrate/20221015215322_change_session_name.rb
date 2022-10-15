class ChangeSessionName < ActiveRecord::Migration[6.1]
  def change
     rename_table :flashcards_session, :session
  end
end
