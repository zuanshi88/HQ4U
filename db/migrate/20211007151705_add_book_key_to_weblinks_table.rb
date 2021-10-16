class AddBookKeyToWeblinksTable < ActiveRecord::Migration[6.1]
  def change
    add_reference :weblinks, :book
  end
end
