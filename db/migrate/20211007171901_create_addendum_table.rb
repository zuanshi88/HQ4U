class CreateAddendumTable < ActiveRecord::Migration[6.1]
  def change
    create_table :addendums do |t| 
      t.belongs_to :note 
      t.string :addition
      t.timestamps 
    end 
  end
end
