class CreateContactRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_roles do |t|
      t.references :contact, foreign_key: true
      t.references :role, foreign_key: true

      t.timestamps
    end
  end
end
