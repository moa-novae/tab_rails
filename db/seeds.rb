# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
2.times {Group.create([
                        name: Faker::Hipster.sentence(word_count: 2), 
                        description: Faker::Hipster.sentence(word_count: 10)
                      ])}
10.times {User.create([
                        name: Faker::Name.name,
                        phone: Faker::PhoneNumber.phone_number
                      ])}

Group.first.users << User.limit(5)
Group.second.users << User.limit(5).offset(5)

20.times do |index| 
  user = User.all.sample
  group = user.groups.sample
  Transaction.create([
                       amount: Faker::Number.between(from: 500, to: 3000), 
                       user_id: user.id, 
                       group_id: group.id
                    ])
end