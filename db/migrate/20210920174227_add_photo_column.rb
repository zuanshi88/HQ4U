class AddPhotoColumn < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :photo, :string
  end

end
