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

require 'rails_helper'

RSpec.describe Thermostat, type: :model do
  it { should have_many(:readings).dependent(:destroy) }
  it { should validate_presence_of(:household_token) }
  it { should validate_presence_of(:location) }
end
