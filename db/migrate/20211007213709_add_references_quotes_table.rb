class AddReferencesQuotesTable < ActiveRecord::Migration[6.1]
  def change
    add_reference :quotes, :entry 
    add_reference :quotes, :book
  end
end
