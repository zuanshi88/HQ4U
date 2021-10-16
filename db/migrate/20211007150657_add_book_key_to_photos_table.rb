class AddBookKeyToPhotosTable < ActiveRecord::Migration[6.1]
  def change
    add_reference :photos, :book
  end
end
