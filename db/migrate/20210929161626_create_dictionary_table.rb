class CreateDictionaryTable < ActiveRecord::Migration[6.1]
  def change
    create_table :dictionaries do |t|
      t.string :title 
      t.timestamps
    end 
  end
end
