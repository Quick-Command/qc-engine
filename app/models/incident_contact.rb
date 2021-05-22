class IncidentContact < ApplicationRecord
  belongs_to :incident
  belongs_to :contact

  validates_presence_of :incident_id, :contact_id
  validates :incident_id, :uniqueness => { :scope => :contact_id }
end
