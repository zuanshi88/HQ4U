class CreateEntryTable < ActiveRecord::Migration[6.1]
  def change
    create_table :entries do |t|
      t.belongs_to :dictionary 
      t.string :term 
      t.string :info 
      t.string :more_info
      t.string :photo
      t.timestamps
    end 
  end
end
