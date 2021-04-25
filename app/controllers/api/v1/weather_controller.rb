class Api::V1::WeatherController < ApplicationController

  def forecast
    render json: ForecastSerializer.new(WeatherFacade.forecast_info(params[:location]))
    end

  def photo
    photo = WeatherFacade.background_info(params[:location])
    if photo.empty?
      render json: NullSerializer.new
    else
      render json: PhotoSerializer.new(photo)
    end
  end
end
