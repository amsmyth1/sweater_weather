class Api::V1::RoadTripsController < ApplicationController

  def create
    road_trip = RoadtripsFacade.create_roadtrip(params)
    if road_trip == []
      render json: {error: "locations do not support a road trip"}, status: 204
    else
      render json: RoadTripSerializer.new(road_trip)
    end
  end
end
