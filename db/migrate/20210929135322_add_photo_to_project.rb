class AddPhotoToProject < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :photos, :string    
  end
end
