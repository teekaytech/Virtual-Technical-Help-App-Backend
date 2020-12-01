FactoryBot.define do
  factory :user do
    name { Faker::Name.unique.name }
    username { Faker::Twitter.screen_name }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
