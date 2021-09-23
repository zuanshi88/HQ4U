class CreateActivitiesTable < ActiveRecord::Migration[6.1]
  def change
    create_table :activities do |t|
      t.belongs_to :account
      t.string :title
      t.string :description
      t.timestamps
    end
  end
end 
