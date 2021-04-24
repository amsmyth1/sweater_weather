class Api::V1::WeatherController < ApplicationController

  def forecast
    coordinates = MapQuestService.coordinates(params[:location])
    weather_info = WeatherService.one_call(coordinates)
    # binding.pry
    # search_key_word = weather_info[:search_key_word]
    photo = PhotoService.search(params[:city])
  end

  def photo
  end
end
