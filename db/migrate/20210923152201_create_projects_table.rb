class CreateProjectsTable < ActiveRecord::Migration[6.1]
  def change
      create_table :projects do |t|
      t.belongs_to :account
      t.string :title
      t.string :description
      t.timestamps
    end
  end 
end
