# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Thermostat.destroy_all
t = Thermostat.create({
  household_token: "token",
  location: { street: "1428 Elm Street", city: "Los Angeles", zip: "900150" }
})
t2 = Thermostat.create({
  household_token: "token2",
  location: { street: "Bag-end", city: "The Shire", zip: "SHB10" }
})

track_no = Reading.generate_tracking_number t.household_token
Reading.create({
  thermostat_id: t.id,
  temperature: 25,
  humidity: 50,
  battery_charge: 86.5,
  tracking_number: track_no
})

track_no = Reading.generate_tracking_number t.household_token
Reading.create({
  thermostat_id: t.id,
  temperature: 24,
  humidity: 55,
  battery_charge: 83.5,
  tracking_number: track_no
})

track_no = Reading.generate_tracking_number t.household_token
Reading.create({
  thermostat_id: t.id,
  temperature: 24.5,
  humidity: 53,
  battery_charge: 80,
  tracking_number: track_no
})

track_no = Reading.generate_tracking_number t.household_token
Reading.create({
  thermostat_id: t.id,
  temperature: 20,
  humidity: 35,
  battery_charge: 75,
  tracking_number: track_no
})

track_no = Reading.generate_tracking_number t2.household_token
Reading.create({
  thermostat_id: t2.id,
  temperature: 24.5,
  humidity: 53,
  battery_charge: 80,
  tracking_number: track_no
})

track_no = Reading.generate_tracking_number t2.household_token
Reading.create({
  thermostat_id: t2.id,
  temperature: 20,
  humidity: 35,
  battery_charge: 75,
  tracking_number: track_no
})