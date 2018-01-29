FactoryBot.define do
  factory :bucket do
    title { Faker::Lorem.word }
    description { Faker::RickAndMorty.quote }
  end
end
