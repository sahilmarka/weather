class Forecast
  CACHE_EXPIRATION = 30.minutes

  attr_reader :current_temperature, :high, :low, :extended_forecast

  attr_accessor :from_cache

  def initialize(attributes)
    @current_temperature = attributes[:current_temperature]
    @high = attributes[:high]
    @low = attributes[:low]
    @extended_forecast = attributes[:extended_forecast]
    @from_cache = attributes[:from_cache]
  end

  def self.for_address(address)
    address = Geocoder.search(address).first
    cache_key = "weather-#{address.postal_code}/#{address.country_code}"
    cache_exists = Rails.cache.exist?(cache_key)
    forecast_obj = Rails.cache.fetch(cache_key, expires_in: CACHE_EXPIRATION) do
      # Retrieve the forecast data from a weather API or other source
      forecast_data = retrieve_forecast_data(address)

      # Create a Forecast object with the retrieved data
      new(
        current_temperature: forecast_data[:current_temperature],
        high: forecast_data[:high],
        low: forecast_data[:low],
        extended_forecast: forecast_data[:extended_forecast],
        from_cache: false
      )
    end

    forecast_obj.from_cache = cache_exists
    forecast_obj
  end

  def self.retrieve_forecast_data(address)
    WeatherService.fetch_weather(address)
  end
end
