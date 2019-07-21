class ThermostatsController < ApplicationController
  before_action :set_thermostat, only: [:stats]

  def stats
    temp_avg = @thermostat.readings.average(:temperature)
    temp_max = @thermostat.readings.maximum(:temperature)
    temp_min = @thermostat.readings.minimum(:temperature)
    hum_avg = @thermostat.readings.average(:humidity)
    hum_max = @thermostat.readings.maximum(:humidity)
    hum_min = @thermostat.readings.minimum(:humidity)
    bc_avg = @thermostat.readings.average(:battery_charge)
    bc_max = @thermostat.readings.maximum(:battery_charge)
    bc_min = @thermostat.readings.minimum(:battery_charge)

    render json: { 
      temperature: {
        average: temp_avg,
        maximum: temp_max,
        minimum: temp_min,
      },
      humidity: {
        average: hum_avg,
        maximum: hum_max,
        minimum: hum_min,
      },
      battery_charge: {
        average: bc_avg,
        maximum: bc_max,
        minimum: bc_min,
      }
    }, status: :ok
  end

private
  def set_thermostat
    @thermostat = Thermostat.find(params[:thermostat_id])
  end
end
