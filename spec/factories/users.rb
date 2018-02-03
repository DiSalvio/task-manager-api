FactoryBot.define do 
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password 'P45sword'
  end
end
