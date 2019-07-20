require 'rails_helper'

RSpec.describe 'Readings API', type: :request do
  # initialize test data 
  let!(:readings) { create_list(:reading, 10) }
  let(:tracking_number) { readings.first.tracking_number }
  let(:thermostat_id) { readings.first.thermostat_id }

  describe 'POST /thermostats/:thermostat_id/readings' do
    let(:valid_attributes) { 
      { temperature: 20, humidity: 45, battery_charge: 80 } 
    }

    context 'when the request is valid' do
      before { 
        post "/thermostats/#{thermostat_id}/readings", params: valid_attributes 
      }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { 
        post "/thermostats/#{thermostat_id}/readings", params: { 
            temperature: 24, battery_charge: 80 
          } 
      }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to eq("{\"humidity\":[\"can't be blank\"]}")
      end
    end
  end

  describe 'GET /thermostats/:thermostat_id/readings/:tracking_number' do
    before { get "/thermostats/#{thermostat_id}/readings/#{tracking_number}" }

    context 'when the record exists' do
      it 'returns the reading' do
        expect(json).not_to be_empty
        expect(json['tracking_number']).to eq(tracking_number)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:tracking_number) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Reading/)
      end
    end
  end
end