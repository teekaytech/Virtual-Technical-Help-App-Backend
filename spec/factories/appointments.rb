FactoryBot.define do
  factory :appointment do
    user_id { nil }
    engineer_id { nil }
    date { Faker::Date.in_date_period(year: 2018, month: 2) }
    session { %i[morning afternoon evening].sample }
    status { %i[booked unbooked].sample }
  end
end
