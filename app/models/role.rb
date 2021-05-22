class Role < ApplicationRecord
  validates_presence_of :title, presence: true
end
