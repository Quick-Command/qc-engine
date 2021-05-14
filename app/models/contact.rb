class Contact < ApplicationRecord
  validates_presence_of :name, presence: true
  validates_presence_of :email, presence: true
  validates_presence_of :phone_number, presence: true 
end
