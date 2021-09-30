class CreatePhotosTable < ActiveRecord::Migration[6.1]
  def change
      create_table :photos do |t|
          t.belongs_to :project
          t.string :title 
          t.string :photo 
          t.string :description
          t.timestamps
      end 
    end
end
