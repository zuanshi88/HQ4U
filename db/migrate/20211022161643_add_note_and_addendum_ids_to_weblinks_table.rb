class AddNoteAndAddendumIdsToWeblinksTable < ActiveRecord::Migration[6.1]
  def change
    add_reference :weblinks, :note 
    add_reference :weblinks, :addendum  
  end
end
