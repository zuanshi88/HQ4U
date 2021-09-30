class AddTopicTagColumnToEntriesTable < ActiveRecord::Migration[6.1]
  def change
    add_column :entries, :topic_tag, :string
  end
end
