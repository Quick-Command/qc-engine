class Incident < ApplicationRecord
  has_many :incident_contacts
  has_many :contacts, through: :incident_contacts
  
  validates_presence_of :name, presence: true
  validates_presence_of :start_date, presence: true
  validates_presence_of :close_date, if: -> { self.active == false }
  validates_presence_of :incident_type, presence: true
  validates_presence_of :city, presence: true
  validates_presence_of :state, presence: true

  def self.active(status)
    where(active: status)
  end
end
