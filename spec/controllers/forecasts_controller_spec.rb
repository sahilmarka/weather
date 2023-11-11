require 'rails_helper'

RSpec.describe ForecastsController, type: :controller do
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
  end
end
