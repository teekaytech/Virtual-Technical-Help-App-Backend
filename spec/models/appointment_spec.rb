require 'rails_helper'

RSpec.describe Appointment, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:engineer) }
  it { should validate_presence_of(:date) }
  it { should validate_presence_of(:duration) }
  it { should validate_presence_of(:status) }
end
