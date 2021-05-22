class CreateIncidentContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :incident_contacts do |t|
      t.references :incident, foreign_key: true
      t.references :contact, foreign_key: true
      t.references :role, foreign_key: true
    end
  end
end
