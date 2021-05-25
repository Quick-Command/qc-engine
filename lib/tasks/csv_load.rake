require 'csv'

namespace :csv_load do

  def build(file, klass)
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      row_without_id = row.delete(:id)
      attributes = row.to_hash
      attributes[:status].gsub!(' ', '_') unless attributes[:status].nil?
      klass.create!(attributes)
    end
  end

  task all: :environment do
    build("./db/data/contacts.csv", Contact)
    build("./db/data/incidents.csv", Incident)
    build("./db/data/roles.csv", Role)
    build("./db/data/contact_roles.csv", ContactRole)
    build("./db/data/incident_contacts_1.csv", IncidentContact)
  end

  desc "TODO"
  task contacts: :environment do
    build("./db/data/contacts.csv", Contact)
  end

  desc "TODO"
  task incidents: :environment do
    build("./db/data/incidents.csv", Incident)
  end

  desc "TODO"
  task roles: :environment do
    build("./db/data/roles.csv", Role)
  end

  desc "TODO"
  task contact_roles: :environment do
    build("./db/data/contact_roles.csv", ContactRole)
  end

  desc "TODO"
  task incident_contacts: :environment do
    build("./db/data/incident_contacts_1.csv", IncidentContact)
  end
end
