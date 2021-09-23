class CreateNotesTable < ActiveRecord::Migration[6.1]
  def change
    create_table :notes do |t|
      t.belongs_to :project
      t.string :comment
      t.timestamps
    end 
  end
end
