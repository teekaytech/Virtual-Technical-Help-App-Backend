# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(
  name: 'John Doe',
  username: 'johndoe',
  email: 'john@doe.com',
  password: 'password',
  password_confirmation: 'password'
)

10.times do
  Engineer.create(
    name: Faker::Name.unique.name,
    stack: %i[MEAN LAMP FULL-STACK DJANGO BITNAMI-DEVPACK LAPP XAMPP MAMP].sample,
    location: Faker::Address.country,
    avatar_link: Faker::Avatar.image
  )
end
