FactoryBot.define do
  factory :appointment do
    user
    engineer
    date { Faker::Date.in_date_period(year: 2018, month: 2) }
    duration { '4 hr' }
    status { %i[booked unbooked].sample }
  end
end
