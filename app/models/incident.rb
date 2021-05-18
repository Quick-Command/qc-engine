class Incident < ApplicationRecord
  validates_presence_of :name, presence: true
  validates_presence_of :location, presence: true
  validates_presence_of :start_date, presence: true
  validates_presence_of :incident_type, presence: true

  def self.active(status)
    where(active: status)
  end
end
