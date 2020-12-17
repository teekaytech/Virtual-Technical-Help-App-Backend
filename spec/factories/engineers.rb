FactoryBot.define do
  factory :engineer do
    name { Faker::Name.unique.name }
    stack { Faker::Twitter.screen_name }
    location { "#{name}@gmail.com".downcase }
    avatar_link { Faker::Avatar.image }
  end
end
