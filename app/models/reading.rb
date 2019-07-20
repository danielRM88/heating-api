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
end
