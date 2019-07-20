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

require 'rails_helper'

RSpec.describe Reading, type: :model do
  it { should belong_to(:thermostat) }
  it { should validate_presence_of(:temperature) }
  it { should validate_presence_of(:humidity) }
  it { should validate_presence_of(:battery_charge) }
end
