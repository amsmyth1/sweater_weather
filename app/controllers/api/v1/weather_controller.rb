class Api::V1::WeatherController < ApplicationController

  def forecast
    coordinates = MapQuestService.coordinates(params[:location])
    weather_info = WeatherService.one_call(coordinates)
    if weather_info[:error] == nil
      render json: ForecastSerializer.new(weather_info[:weather])
    else
      render json: ErrorSerializer.new(weather_info)
    end
    # binding.pry
    # search_key_word = weather_info[:search_key_word]
    # photo = PhotoService.search(params[:city])
  end

  def photo
  end
end
