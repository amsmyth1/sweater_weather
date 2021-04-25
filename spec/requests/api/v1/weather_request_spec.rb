require 'rails_helper'

RSpec.describe "Weather API Endpoints" do
  describe "weather happy path" do
    it "returns" do
      get "/api/v1/forecast?location=denver,co"
      expect(response).to be_successful
      weather = JSON.parse(response.body, symbolize_names:true)

      expect(weather).to be_a(Hash)
      expect(weather[:data]).to be_a(Hash)
      expect(weather[:data].keys).to eq([:id, :type, :attributes])
      expect(weather[:data][:type]).to eq("forecast")
      expect(weather[:data][:attributes]).to be_a(Hash)
      expect(weather[:data][:attributes].class).to eq(Hash)
      expect(weather[:data][:attributes].keys).to eq([:current_weather, :daily_weather, :hourly_weather])
      expect(weather[:data][:attributes][:current_weather]).to be_a(Hash)
      expect(weather[:data][:attributes][:current_weather].keys).to eq([:datetime, :sunrise, :sunset, :temperature, :feels_like, :humidity, :uvi, :visibility, :conditions, :icon])
      expect(weather[:data][:attributes][:current_weather][:temperature]).to be_a(Float)
      expect(weather[:data][:attributes][:current_weather][:feels_like]).to be_a(Float)
      expect(weather[:data][:attributes][:current_weather][:humidity]).to be_a(Integer)
      expect(weather[:data][:attributes][:current_weather][:uvi]).to be_a(Float)
      expect(weather[:data][:attributes][:current_weather][:visibility]).to be_a(Integer)
      expect(weather[:data][:attributes][:daily_weather]).to be_an(Array)
      expect(weather[:data][:attributes][:daily_weather].count).to eq(5)
      expect(weather[:data][:attributes][:daily_weather].first).to be_a(Hash)
      expect(weather[:data][:attributes][:daily_weather].first.keys).to eq([:date, :sunrise, :sunset, :max_temp, :min_temp, :conditions, :icon])
      expect(weather[:data][:attributes][:hourly_weather]).to be_an(Array)
      expect(weather[:data][:attributes][:hourly_weather].count).to eq(8)
      expect(weather[:data][:attributes][:hourly_weather].first).to be_a(Hash)
      expect(weather[:data][:attributes][:hourly_weather].first.keys).to eq([:time, :temperature, :conditions, :icon])


    end
  end
  describe "weather sad path" do
    it "returns" do
      get "/api/v1/forecast?location=njnasdfjn"
      expect(response).to be_successful
      weather = JSON.parse(response.body, symbolize_names:true)

      expect(weather).to be_a(Hash)
      expect(weather[:data]).to eq(nil)
      expect(weather[:error]).to eq("")
    end
  end
  describe "photo" do
    it "sends a photo for the page" do

      get "/api/v1/backgrounds"
      expect(response).to be_successful
      background = JSON.parse(response.body, symbolize_names:true)

      expect(background).to be_a(Hash)
      expect(background[:data]).to be_a(Hash)
      expect(background[:data].keys).to eq([:id, :type, :attributes])
      expect(background[:data][:type]).to eq("image")
      expect(background[:data][:attributes]).to be_a(Hash)
      expect(background[:data][:attributes][:image]).to be_a(Hash)
      expect(background[:data][:attributes][:image].keys).to eq([:location, :image_url, :credit])
      expect(background[:data][:attributes][:image][:credits]).to be_a(Hash)
      expect(background[:data][:attributes][:image][:credits].keys).to eq([:source, :author, :logo])
    end
  end
end
