class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :engineer
  validates_presence_of :date, :duration, :status
end
