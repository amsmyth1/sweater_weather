class WeatherFacade

  def self.forecast_info(location)
    coordinates = MapQuestService.coordinates(location)
    weather_info = WeatherService.one_call(coordinates)
    weather_info[:weather]
  end
end
