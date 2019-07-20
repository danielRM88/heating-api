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
    # TODO send creation to the background
    reading = Reading.new reading_params
    reading.thermostat = @thermostat

    if reading.save
      render json: reading, status: :created
    else
      render json: reading.errors, status: :unprocessable_entity
    end
  end

private
  def reading_params
    params.permit(:temperature, :humidity, :battery_charge)
  end

  def set_thermostat
    @thermostat = Thermostat.find(params[:thermostat_id])
  end

  def set_reading
    @reading = Reading.find_by_tracking_number(params[:tracking_number])
  end
end
