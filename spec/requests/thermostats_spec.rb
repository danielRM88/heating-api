require 'rails_helper'

RSpec.describe 'Thermostat API', type: :request do
  let!(:thermostats) { create_list(:thermostat, 1, { readings: create_list(:reading, 10) }) }
  let(:thermostat_id) { thermostats.first.id }
  let(:readings) { 
    thermostats.first.readings
  }

  describe 'GET /thermostats/:thermostat_id/stats' do
    before { get "/thermostats/#{thermostat_id}/stats" }
      
    it 'returns the stats' do
      expect(json).not_to be_empty
      expect(json['temperature']['average']).to eq(readings.average(:temperature).to_s)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end