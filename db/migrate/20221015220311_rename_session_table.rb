class RenameSessionTable < ActiveRecord::Migration[6.1]
  def change
     rename_table :session, :sessions
  end

end
