FactoryBot.define do
  factory :appointment do
    user_id { 1 }
    engineer_id { 1 }
    date { Faker::Date.in_date_period(year: 2018, month: 2) }
    duration { %i[morning afternoon evening].sample }
    status { %i[booked unbooked].sample }
  end
end
