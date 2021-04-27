require 'rails_helper'

RSpec.describe "Road Trip API Endpoint" do
  describe "create a road trip - happy path" do
    it "creates a new road trip start city, end city, travel time in hour/minutes, weather at eta {temp, conditions}" do
      road_trip_params = ({
        email: "whatever@example.com",
        password_digest: "password",
        password_confirmation: "password"
      })
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/users", headers: headers, params: JSON.generate(user_params)
      created_road_trip = RoadTrip.last

    end
  end
end
