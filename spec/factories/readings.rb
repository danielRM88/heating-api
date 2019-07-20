FactoryBot.define do
  factory :reading do
    thermostat_id { nil }
    tracking_number { Faker::Number.number(10) }
    temperature { Faker::Number.number(15) }
    humidity { Faker::Number.number(50) }
    battery_charge { Faker::Number.number(100) }
  end
end