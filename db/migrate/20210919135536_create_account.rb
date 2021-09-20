class CreateAccount < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.string :name 
      t.string :street_address
      t.string :city 
      t.string :state 
      t.integer :zipcode 
      t.timestamps 
  end
end   
  
end
