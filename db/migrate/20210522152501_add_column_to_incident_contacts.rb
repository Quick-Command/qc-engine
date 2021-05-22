class AddColumnToIncidentContacts < ActiveRecord::Migration[5.2]
  def change
    add_column :incident_contacts, :title, :string
  end
end
