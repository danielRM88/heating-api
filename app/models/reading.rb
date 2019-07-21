# == Schema Information
#
# Table name: readings
#
#  id              :bigint           not null, primary key
#  thermostat_id   :bigint           not null
#  tracking_number :integer          not null
#  temperature     :float            not null
#  humidity        :float            not null
#  battery_charge  :float            not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Reading < ApplicationRecord
  @@lock = Mutex.new

  belongs_to :thermostat
  validates_presence_of :tracking_number
  validates_presence_of :temperature
  validates_presence_of :humidity
  validates_presence_of :battery_charge

  validate :uniqueness_of_track_no

  scope :find_all_readings_of_household, -> (token) { 
    Reading.joins(:thermostat).where(thermostats: {household_token: token})
  }

  scope :find_by_track_no_and_household, -> (track_no, token) {
    joins(:thermostat).where(tracking_number: track_no)
    .where(thermostats: { household_token: token })
  }

  def uniqueness_of_track_no
    dup = Reading.find_by_track_no_and_household(self.tracking_number, 
        self.thermostat.household_token).count > 0

    if dup
      self.errors.add(:tracking_number, "must be unique by household")
    end
  end

  def self.generate_tracking_number household_token
    max = nil
    @@lock.synchronize do
      readings = Reading.find_all_readings_of_household(household_token)
      max = readings.maximum(:tracking_number).to_i
      max += 1
    end

    max
  end
end
