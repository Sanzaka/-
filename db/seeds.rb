# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



# 10.times do |n|
#   name = Faker::Name.name
#   email = Faker::Internet.email
#   password = "asdfgh#{n + 1}"


#   user = User.new

#   user.name = "#{name}"
#   user.email = "#{email}"
#   user.password = password
#   user.created_at = DateTime.now
#   user.updated_at = DateTime.now

#   user.save!
# end

user = User.new

user.name = "name"
user.email = 'test@example.com'
user.password = '#$taawktljasktlw4aaglj'
user.encrypted_password = '#$taawktljasktlw4aaglj'
user.save!