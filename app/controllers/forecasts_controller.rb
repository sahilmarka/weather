# controller to show weather details
class ForecastsController < ApplicationController
  def show
    @address = params[:address]
    @weather = Forecast.for_address(@address) if @address.present?
  rescue => e
    flash.alert = e.message
  end
end
