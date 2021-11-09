class AddReferenceForAddToNotesTable < ActiveRecord::Migration[6.1]
  def change
    add_reference :notes, :addendum
    
  end
end
