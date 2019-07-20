FactoryBot.define do
  factory :thermostat do
    household_token { Faker::Beer.brand }
    location { 
      { 
        street: Faker::Address.street_address,
        city: Faker::Address.city,
        zip: Faker::Address.zip
      } 
    }
  end
end