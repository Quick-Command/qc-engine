class Role < ApplicationRecord
  has_many :contact_roles
  has_many :contacts, through: :contact_roles

  validates_presence_of :title, presence: true
  validates_uniqueness_of :title
end
