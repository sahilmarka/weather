require 'rails_helper'

RSpec.describe Forecast, type: :model do

  let(:cache_key) { 'weather-500072/IN' }

  before(:each) do
    allow(Geocoder).to receive(:search).and_return([OpenStruct.new(postal_code: '500072', country_code: 'IN', latitude: '17.360589', longitude: '78.4740613')])
    allow(WeatherService).to receive(:call_weather_api).and_return({ 'temp' => 226,
                                                                     'temp_max' => 230,
                                                                     'temp_min' => 200,
                                                                     'feels_like' => 232 })
  end

  it 'should fetch weather with cache set as false' do
    weather_obj = described_class.for_address('Hyderabad')
    expect(weather_obj.current_temperature).to eq(226)
    expect(weather_obj.extended_forecast).to eq(232)
    expect(weather_obj.high).to eq(230)
    expect(weather_obj.low).to eq(200)
    expect(weather_obj.from_cache).to be_falsy
  end

  it 'should set from_cache as true' do
    allow(Rails.cache).to receive(:exist?).with(cache_key).and_return(true)
    weather_obj = described_class.for_address('Hyderabad')
    expect(weather_obj.current_temperature).to eq(226)
    expect(weather_obj.extended_forecast).to eq(232)
    expect(weather_obj.high).to eq(230)
    expect(weather_obj.low).to eq(200)
    expect(weather_obj.from_cache).to be_truthy
  end
end
