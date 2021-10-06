class AddAnnualColumnToActivitiesTable < ActiveRecord::Migration[6.1]
  def change
    add_column :activities, :annual, :boolean, :default => false
  end
end
