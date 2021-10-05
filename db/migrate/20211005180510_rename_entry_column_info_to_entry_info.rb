class RenameEntryColumnInfoToEntryInfo < ActiveRecord::Migration[6.1]
  def change
    rename_column :entries, :info, :entry_info
  end
end
