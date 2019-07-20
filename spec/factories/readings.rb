FactoryBot.define do
  factory :reading do
    association :thermostat
    tracking_number { Faker::Number.number(4) }
    temperature { Faker::Number.number(2) }
    humidity { Faker::Number.number(2) }
    battery_charge { Faker::Number.number(2) }
  end
end