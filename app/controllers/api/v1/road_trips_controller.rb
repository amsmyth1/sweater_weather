class Api::V1::RoadTripsController < ApplicationController

  def create
    render json: RoadTripSerializer.new(create_roadtrip(params))
  end

  private

  def create_roadtrip(params)
    road_trip = {}
    road_trip[:start_city] = params[:origin]
    road_trip[:end_city] = params[:destination]
    road_trip[:travel_time] = trip_duration(params[:origin], params[:destination])
    road_trip[:weather_at_eta] = {}
    OpenStruct.new(road_trip)
  end

  def trip_duration(origin, destination)
    response = Faraday.get("http://www.mapquestapi.com/directions/v2/route?key=#{ENV['mapquest_api_key']}&from=#{origin}&to=#{destination}")
    raw_data = JSON.parse(response.body, symbolize_names: true)
    time = raw_data[:route][:formattedTime]
    "#{time[0,2]} hours, #{time[3,2]} minutes"
  end
end
