class IncidentContact < ApplicationRecord
  belongs_to :incident
  belongs_to :contact

  validates_presence_of :incident_id, :contact_id
  validates_presence_of :title, presence: true
  validates :incident_id, :uniqueness => { :scope => :contact_id }

  def self.contact_title(contact_id, incident_id)
    where(contact_id: contact_id)
    .where(incident_id: incident_id)
    .pluck(:title).first
  end
end
