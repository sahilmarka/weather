require 'rails_helper'

RSpec.describe ForecastsController, type: :controller do
  let(:cache_key) { 'weather-500072/IN' }

  before(:each) do
    allow(Geocoder).to receive(:search).and_return([OpenStruct.new(postal_code: '500072', country_code: 'IN', latitude: '17.360589', longitude: '78.4740613')])
    allow(WeatherService).to receive(:call_weather_api).and_return({ 'temp' => 226,
                                                                     'temp_max' => 230,
                                                                     'temp_min' => 200,
                                                                     'feels_like' => 232 })
  end

  it 'should fetch weather with cache set as false' do
    get :show, params: { address: 'Hyderabad' }
    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body)).to match({ 'current_temperature' => 226,
                                                 'high' => 230,
                                                 'low' => 200,
                                                 'extended_forecast' => 232,
                                                 'from_cache' => false })
  end
  
  it 'should set from_cache as true' do
    allow(Rails.cache).to receive(:exist?).with(cache_key).and_return(true)
    get :show, params: { address: 'Hyderabad' }
    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body)).to match({ 'current_temperature' => 226,
                                                 'high' => 230,
                                                 'low' => 200,
                                                 'extended_forecast' => 232,
                                                 'from_cache' => true })
  end
end
