class Contact < ApplicationRecord
  has_many :incident_contacts
  has_many :incidents, through: :incident_contacts
  has_many :contact_roles
  has_many :roles, through: :contact_roles

  validates_presence_of :name, presence: true
  validates_presence_of :email, presence: true
  validates_presence_of :phone_number, presence: true
  validates_presence_of :job_title, presence: true
  validates_presence_of :city, presence: true
  validates_presence_of :state, presence: true
end
