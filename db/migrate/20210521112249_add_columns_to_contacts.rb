class AddColumnsToContacts < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :city, :string
    add_column :contacts, :state, :string
  end
end
