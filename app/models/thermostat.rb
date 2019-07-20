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
end
