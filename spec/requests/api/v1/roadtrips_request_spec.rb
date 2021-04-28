require 'rails_helper'

RSpec.describe "Road Trip API Endpoint" do
  describe "create a road trip - happy path" do
    it "creates a new road trip start city, end city, travel time in hour/minutes, weather at eta {temp, conditions}" do
      VCR.use_cassette('roadtrip-48') do
        user_params = ({
          email: "whatever@example.com",
          password: "password",
          password_confirmation: "password"
        })
        @created_user = User.create(user_params)

        road_trip_params = ({
          origin: "Denver,CO",
          destination: "Pueblo,CO",
          api_key: "#{@created_user.api_key}"
        })
        headers = {"CONTENT_TYPE" => "application/json"}
        post "/api/v1/road_trip", headers: headers, params: JSON.generate(road_trip_params)

        expect(response).to be_successful
        data = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(data[:id]).to eq(nil)
        expect(data[:type]).to eq("roadtrip")
        expect(data[:attributes]).to be_a(Hash)
        expect(data[:attributes].keys).to eq([:start_city, :end_city, :travel_time, :weather_at_eta])
        expect(data[:attributes][:start_city]).to eq(road_trip_params[:origin])
        expect(data[:attributes][:end_city]).to eq(road_trip_params[:destination])
        expect(data[:attributes][:travel_time]).to be_a(String)
        expect(data[:attributes][:weather_at_eta]).to be_a(Hash)
        expect(data[:attributes][:weather_at_eta].keys).to eq([:temperature, :conditions])
      end
    end
    it "creates a new road trip start city, end city, travel time in hour/minutes, weather at eta {temp, conditions}" do
      VCR.use_cassette('roadtrip-6') do
        user_params = ({
          email: "whatever@example.com",
          password: "password",
          password_confirmation: "password"
        })
        @created_user = User.create(user_params)

        road_trip_params = ({
          origin: "philadelphia,pa",
          destination: "cherryhill,nj",
          api_key: "#{@created_user.api_key}"
        })
        headers = {"CONTENT_TYPE" => "application/json"}
        post "/api/v1/road_trip", headers: headers, params: JSON.generate(road_trip_params)

        expect(response).to be_successful
        data = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(data[:id]).to eq(nil)
        expect(data[:type]).to eq("roadtrip")
        expect(data[:attributes]).to be_a(Hash)
        expect(data[:attributes].keys).to eq([:start_city, :end_city, :travel_time, :weather_at_eta])
        expect(data[:attributes][:start_city]).to eq(road_trip_params[:origin])
        expect(data[:attributes][:end_city]).to eq(road_trip_params[:destination])
        expect(data[:attributes][:travel_time]).to be_a(String)
        expect(data[:attributes][:weather_at_eta]).to be_a(Hash)
        expect(data[:attributes][:weather_at_eta].keys).to eq([:temperature, :conditions])
      end
    end
    it "creates a new road trip start city, end city, travel time in hour/minutes, weather at eta {temp, conditions}" do
      VCR.use_cassette('roadtrip-days') do
        user_params = ({
          email: "whatever@example.com",
          password: "password",
          password_confirmation: "password"
        })
        @created_user = User.create(user_params)

        road_trip_params = ({
          origin: "Denver,CO",
          destination: "Philadelphia,PA",
          api_key: "#{@created_user.api_key}"
        })
        headers = {"CONTENT_TYPE" => "application/json"}
        post "/api/v1/road_trip", headers: headers, params: JSON.generate(road_trip_params)

        expect(response).to be_successful
        data = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(data[:id]).to eq(nil)
        expect(data[:type]).to eq("roadtrip")
        expect(data[:attributes]).to be_a(Hash)
        expect(data[:attributes].keys).to eq([:start_city, :end_city, :travel_time, :weather_at_eta])
        expect(data[:attributes][:start_city]).to eq(road_trip_params[:origin])
        expect(data[:attributes][:end_city]).to eq(road_trip_params[:destination])
        expect(data[:attributes][:travel_time]).to be_a(String)
        expect(data[:attributes][:weather_at_eta]).to be_a(Hash)
        expect(data[:attributes][:weather_at_eta].keys).to eq([:temperature, :conditions])
      end
    end
  end
  describe "create a road trip - sad path" do
    it "returns a 204 no results status" do
      VCR.use_cassette('roadtrip-sad') do
        user_params = ({
          email: "whatever@example.com",
          password: "password",
          password_confirmation: "password"
        })
        @created_user = User.create(user_params)

        road_trip_params = ({
          origin: "Denver,CO",
          destination: "havana,cuba",
          api_key: "#{@created_user.api_key}"
        })
        headers = {"CONTENT_TYPE" => "application/json"}
        post "/api/v1/road_trip", headers: headers, params: JSON.generate(road_trip_params)

        expect(response.status).to eq(204)
      end
    end
  end
end
