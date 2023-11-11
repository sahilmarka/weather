# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version - 3.2.1

* How to run the test suite - rspec followed by spec_name

* created a forecasts_controller
  functionality of forecast_controller: 
  1.) accepts address from user.
  2.) passes it to Forecast model if address exists
  3.) accepts forecast object from Forecast model
  4.) allows view to access forecast object

* created forecast model
  funcationality of forecast model
  1.) accept address
  2.) passess address to geocoder
  3.) checks where zipcode/country_code cache exists
  4.) retrieves forecast data from cache if cache contains it if not
      calls weather api and retrives data from there
  5.) stores data in cache if data came from api
  6.) updates from_cache key to know whether data is 
      retrieved from cache or api
  7.) passes Forecast object to forecasts controller

 * created WeatherService PORO class
   functionality of WeatherService Class
   1.) accepts geocoder filtered address
   2.) takes latitude and longitude from that object
   3.) passes lat, long to weather api
   4.) filters response of weather api and passes it to forecast model.
  
