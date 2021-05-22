class AddColumnsToIncidents < ActiveRecord::Migration[5.2]
  def change
    add_column :incidents, :city, :string
    add_column :incidents, :state, :string
  end
end
