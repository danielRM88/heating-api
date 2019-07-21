class ReadingCreationWorker
  include Sidekiq::Worker

  def perform(thermostat_id, temperature, humidity, battery_charge, track_no)
    reading = Reading.new({
      thermostat_id: thermostat_id, 
      temperature: temperature, 
      humidity: humidity, 
      battery_charge: battery_charge,
      tracking_number: track_no
    })
    reading.save
  end
end
