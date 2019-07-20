# == Schema Information
#
# Table name: thermostats
#
#  id              :bigint           not null, primary key
#  household_token :text
#  location        :hstore
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Thermostat < ApplicationRecord
  has_many :readings, dependent: :destroy
  validates_presence_of :household_token
  validates_presence_of :location
end
