class RoadtripsFacade

  def self.create_roadtrip(params)
    road_trip = {}
    if trip_duration(params[:origin], params[:destination]) != nil
      road_trip[:start_city] = params[:origin]
      road_trip[:end_city] = params[:destination]
      road_trip[:travel_time] = "#{trip_duration(params[:origin], params[:destination])[0,2]} hours, #{trip_duration(params[:origin], params[:destination])[3,2]} minutes"
      road_trip[:weather_at_eta] = weather(params[:destination], trip_duration(params[:origin], params[:destination]))
      OpenStruct.new(road_trip)
    else
      []
    end
  end

  def self.trip_duration(origin, destination)
    response = Faraday.get("http://www.mapquestapi.com/directions/v2/route?key=#{ENV['mapquest_api_key']}&from=#{origin}&to=#{destination}")
    raw_data = JSON.parse(response.body, symbolize_names: true)
    time = raw_data[:route][:formattedTime]
  end

  def self.weather(destination, duration)
    coordinates = MapQuestService.coordinates(destination)
    weather_info = WeatherService.get_city_weather_by_future_time(coordinates, duration)
  end
end
