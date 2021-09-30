class CreateExampleTable < ActiveRecord::Migration[6.1]
  def change
    create_table :examples do |t|
      t.belongs_to :entry 
      t.string :info 
      t.timestamps 
    end 
  end
end
