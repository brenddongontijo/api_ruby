FactoryBot.define do
  factory :product do
    name { Faker::Lorem.word }
    description { Faker::Lorem.sentence(word_count=4) }
    value { Faker::Number.decimal(3, 2) }
    height { Faker::Number.between(from = 16, to = 50) }
    weight { Faker::Number.between(from = 16, to = 50) }
    width { Faker::Number.between(from = 16, to = 50) }
    length { Faker::Number.between(from = 16, to = 50) }
  end
end