class CreateBooksTable < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.belongs_to :project
      t.string :title
      t.string :author
      t.string :synopsis
      t.integer :pages 
      t.boolean :completed, :default => false
      t.integer :times_read, :default => 0
      t.timestamps
    end
  end
end
