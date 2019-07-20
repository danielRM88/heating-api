require 'rails_helper'

RSpec.describe 'Todos API', type: :request do
  # initialize test data 
  let!(:readings) { create_list(:reading, 10) }
  let(:tracking_number) { readings.first.tracking_number }
  let(:thermostat_id) { readings.first.thermostat_id }

  describe 'POST /reading' do
    let(:valid_attributes) { 
      { temperature: 20, humidity: 45, battery_charge: 80 } 
    }

    context 'when the request is valid' do
      before { post '/reading', params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { 
        post '/reading', params: { temperature: 24, battery_charge: 80 } 
      }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Humidity can't be blank/)
      end
    end
  end

  describe 'GET /readings/:tracking_number' do
    before { get "/readings/#{tracking_number}" }

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

  describe 'GET /readings/:thermostat_id/stats' do
    before { get "/readings/#{thermostat_id}/stats" }

    context 'when readings exists' do
      it 'returns the stats' do
        expect(json).not_to be_empty
        expect(json['temperature']['average']).to eq(20)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when there are no readings' do
      let(:thermostat_id) { 10 }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns an empty array' do
        expect(json['temperature']['average']).to be_nil
      end
    end
  end
end