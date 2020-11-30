require 'rails_helper'

RSpec.describe Engineer, type: :model do
  it { should have_many(:appointments).dependent(:destroy) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:stack) }
  it { should validate_presence_of(:location) }
  it { should validate_presence_of(:avatar_link) }
end
