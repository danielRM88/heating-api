class ReadingsController < ApplicationController
  before_action :set_thermostat, only: [:show, :create]
  before_action :set_reading, only: [:show]

  def show
    if @reading.present?
      render json: @reading, status: :ok
    else
      render json: "Couldn't find Reading", status: :not_found
    end
  end

  def create
    track_no = Reading.generate_tracking_number @thermostat.household_token
    reading = Reading.new reading_params
    reading.tracking_number = track_no

    if reading.valid?
      ReadingCreationWorker.perform_async(
        reading.thermostat_id,
        reading.temperature,
        reading.humidity,
        reading.battery_charge,
        track_no
      )
      render json: reading, status: :created
    else
      render json: reading.errors, status: :unprocessable_entity
    end
  end

private
  def reading_params
    params.permit(:thermostat_id, :temperature, :humidity, :battery_charge)
  end

  def set_thermostat
    @thermostat = Thermostat.find(params[:thermostat_id])
  end

  def set_reading
    @reading = Reading.find_by_tracking_number(params[:tracking_number])
  end
end
