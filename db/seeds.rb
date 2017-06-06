 require 'faker'

10.times do |n|
  puts Usser.create!(name: Faker::Name.name ,email: Faker::Internet.email,password: 123456)
end
