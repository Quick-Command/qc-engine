class AddColumnToContacts < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :job_title, :string
  end
end
