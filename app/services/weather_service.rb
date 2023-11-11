require 'net/http'
require 'json'
# https://api.openweathermap.org/data/2.5/weather?lat=17.4834&lon=78.3871&appid=96ec27c7c256876e34a67ad18ac96514
class WeatherService
  class << self
    API_BASE_URL = 'https://api.openweathermap.org/data/2.5/weather?'.freeze

    attr_reader :address

    def fetch_weather(address)
      @address = address
      response = call_weather_api
      p "RESPONSE ____ ---- >>>> #{response}"

      {
        current_temperature: response['temp'],
        high: response['temp_max'],
        low: response['temp_min'],
        extended_forecast: response['feels_like'],
        from_cache: false
      }
    end

    private

    def call_weather_api
      uri = URI("#{API_BASE_URL}lat=17.360589&lon=78.4740613&appid=96ec27c7c256876e34a67ad18ac96514")  
      response = Net::HTTP.get_response(uri)
      return JSON.parse(response.body)['main'] if response.is_a?(Net::HTTPSuccess)

      raise "unable to fetch information: #{response.code}, #{response.body}"
    end
  end
end
# OpenStruct.new(latitude: 17.360589, longitude: 78.4740613)