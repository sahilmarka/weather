# controller to show weather details
class ForecastsController < ApplicationController
  def show
    @address = params[:address]
    @weather = Forecast.for_address(@address) if @address.present?
    # render json: @weather, status: :ok
  rescue => e
    flash.alert = e.message
    render json: { msg: 'failed to fetch location' }, status: :bad_request
  end
end
