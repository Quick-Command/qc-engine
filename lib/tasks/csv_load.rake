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
  end

  desc "TODO"
  task contacts: :environment do
    build("./db/data/contacts.csv", Contact)
  end

  desc "TODO"
  task incidents: :environment do
    build("./db/data/incidents.csv", Incident)
  end
end
