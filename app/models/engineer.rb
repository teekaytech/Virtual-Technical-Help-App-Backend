class Engineer < ApplicationRecord
  has_many :appointments
  has_many :users, through: :appointments
  validates_presence_of :name, :stack, :location, :avatar_link
end
