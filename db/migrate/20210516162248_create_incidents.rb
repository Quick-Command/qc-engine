class CreateIncidents < ActiveRecord::Migration[5.2]
  def change
    create_table :incidents do |t|
      t.string :name
      t.boolean :active, default: true
      t.string :incident_type
      t.string :description
      t.string :location
      t.datetime :start_date
      t.datetime :close_date

      t.timestamps
    end
  end
end
