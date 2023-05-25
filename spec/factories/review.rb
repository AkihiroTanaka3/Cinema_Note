FactoryBot.define do
  factory :review do
    body { Faker::Lorem.paragraph(sentence_count: 3) }
    rate { rand(1..5) }
    user
    movie
  end
end