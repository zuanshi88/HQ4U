class CreateWeblinksTable < ActiveRecord::Migration[6.1]
  def change
    create_table :weblinks do |t|
      t.belongs_to :project 
      t.string :title 
      t.string :url 
      t.string :description 
    end 
  end
end
