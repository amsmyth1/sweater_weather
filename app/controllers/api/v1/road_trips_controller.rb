class Api::V1::RoadTripsController < ApplicationController

  def create
    render json: RoadTripSerializer.new(create_roadtrip(params))
  end

  private

  def create_roadtrip(params)
    road_trip = {}
    road_trip[:start_city] = params[:origin]
    road_trip[:end_city] = params[:destination]
    road_trip[:travel_time] = "#{trip_duration(params[:origin], params[:destination])[0,2]} hours, #{trip_duration(params[:origin], params[:destination])[3,2]} minutes"
    road_trip[:weather_at_eta] = weather(params[:destination], trip_duration(params[:origin], params[:destination]))
    OpenStruct.new(road_trip)
  end

  def trip_duration(origin, destination)
    response = Faraday.get("http://www.mapquestapi.com/directions/v2/route?key=#{ENV['mapquest_api_key']}&from=#{origin}&to=#{destination}")
    raw_data = JSON.parse(response.body, symbolize_names: true)
    time = raw_data[:route][:formattedTime]
  end

  def weather(destination, duration)
    coordinates = MapQuestService.coordinates(location)
    weather_info = WeatherService.get_city_weather_by_future_time(coordinates, duration)
  end
end
