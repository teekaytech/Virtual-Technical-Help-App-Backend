class Engineer < ApplicationRecord
  has_many :appointments, dependent: :destroy
  validates_presence_of :name, :stack, :location, :avatar_link
end
