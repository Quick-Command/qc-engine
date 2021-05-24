class Contact < ApplicationRecord
  has_many :incident_contacts
  has_many :incidents, through: :incident_contacts
  has_many :contact_roles
  has_many :roles, through: :contact_roles

  validates_presence_of :name, presence: true
  validates_presence_of :email, presence: true
  validates_presence_of :phone_number, presence: true
  validates_presence_of :city, presence: true
  validates_presence_of :state, presence: true

  def assigned_to_active_incident?
    active_incidents = self.incidents.where(active: true)
    if active_incidents.empty?
      false
    else
      true
    end
  end

  def self.remove_active_contacts
    joins(:incidents)
    .where.not('incidents.active = ?', true)
  end

  def self.find_by_role(role_query)
    select('contacts.*')
    .joins(:contact_roles)
    .select("contact_roles.contact_id")
    .joins(:roles)
    .select('roles.title')
    .where("lower(roles.title) LIKE ?", "%#{role_query.downcase}%")
  end
end
