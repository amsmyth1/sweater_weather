class RoadtripsFacade

  def self.create_roadtrip(params)
    road_trip = {}
    if MapQuestService.trip_duration(params[:origin], params[:destination]) != nil
      road_trip[:start_city] = params[:origin]
      road_trip[:end_city] = params[:destination]
      road_trip[:travel_time] = "#{MapQuestService.trip_duration(params[:origin], params[:destination])[0,2]} hours, #{MapQuestService.trip_duration(params[:origin], params[:destination])[3,2]} minutes"
      road_trip[:weather_at_eta] = weather(params[:destination], MapQuestService.trip_duration(params[:origin], params[:destination]))
      OpenStruct.new(road_trip)
    else
      []
    end
  end

  def self.weather(destination, duration)
    coordinates = MapQuestService.coordinates(destination)
    weather_info = WeatherService.get_city_weather_by_future_time(coordinates, duration)
  end
end
