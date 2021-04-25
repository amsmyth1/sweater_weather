class Api::V1::WeatherController < ApplicationController

  def forecast
    coordinates = MapQuestService.coordinates(params[:location])
    weather_info = WeatherService.one_call(coordinates)
    render json: ForecastSerializer.new(weather_info[:weather])
    end

  def photo
    photo = PhotoService.search(params[:location])
    if photo.empty?
      render json: NullSerializer.new
    else
      render json: PhotoSerializer.new(photo)
    end
  end
end
