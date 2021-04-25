class WeatherFacade

  def self.forecast_info(location)
    coordinates = MapQuestService.coordinates(location)
    weather_info = WeatherService.one_call(coordinates)
    OpenStruct.new(weather_info[:weather])
  end

  def self.background_info(query)
    background = PhotoService.search(query)
     if background == []
       []
     else
       OpenStruct.new(background)
     end 
  end
end
