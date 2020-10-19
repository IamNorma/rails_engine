FactoryBot.define do
  factory :invoice do
    association :merchant
    association: :customer
    status { 'shipped' }
  end
end
