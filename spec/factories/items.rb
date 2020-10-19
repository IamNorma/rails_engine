FactoryBot.define do
  factory :item do
    association :merchant
    name { Faker::Commerce.product_name }
    description { Faker::Movie.quote }
    unit_price { Faker::Commerce.price }
  end
end
