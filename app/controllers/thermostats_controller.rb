class ThermostatsController < ApplicationController
  before_action :set_thermostat, only: [:stats]

  def stats
    temp_avg = @thermostat.readings.average(:temperature)
    temp_max = 0
    temp_min = 0
    hum_avg = 0
    hum_max = 0
    hum_min = 0
    bc_avg = 0
    bc_max = 0
    bc_min = 0

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
