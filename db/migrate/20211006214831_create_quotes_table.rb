class CreateQuotesTable < ActiveRecord::Migration[6.1]
  def change
    create_table :quotes do |t|
      t.string :text 
      t.string :author 
      t.string :source 
      t.timestamps
    end 
  end
end
