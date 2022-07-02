class AddPendingColumnToAddendums < ActiveRecord::Migration[6.1]
  def change
    change_table :addendums do |t|
       t.column :pending?, :boolean, default: false
    end 
  end
end
