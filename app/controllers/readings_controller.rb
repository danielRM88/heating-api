class ReadingsController < ApplicationController
  def show
  end

  def create
    # TODO send creation to the background
  end

private
  def reading_params
    params.require(:reading).permit(:temperature, :humidity, :battery_charge)
  end

end
