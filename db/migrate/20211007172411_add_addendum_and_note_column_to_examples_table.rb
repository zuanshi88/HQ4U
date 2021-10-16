class AddAddendumAndNoteColumnToExamplesTable < ActiveRecord::Migration[6.1]
  def change
    add_reference :examples, :note 
    add_reference :examples, :addendum
  end
end
