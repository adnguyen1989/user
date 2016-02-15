# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

50.times do |i|
  User.create(first_name: "first_name#{i+1}", last_name: "last_name#{i+1}", email: "email#{i+1}@gmail.com", password: "password#{i+1}", password_confirmation: "password#{i+1}")
end
