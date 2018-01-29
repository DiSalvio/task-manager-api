FactoryBot.define do
  factory :task do
    title { Faker::Lorem.word }
    description { Faker::RickAndMorty.quote }
    bucket_id nil
  end
end
