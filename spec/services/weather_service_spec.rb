require 'rails_helper'

RSpec.describe "WeatherService", type: :feature do
  describe "::weather_data" do
    it "should return the desired weather information when given coordinates" do
      coords = {:lat=>39.738453, :lng=>-104.984853}
      info = WeatherService.get_city_info(coords)

      expect(info.class).to eq(Hash)
      expect(info.keys).to eq([:lat, :lon, :timezone, :timezone_offset, :current, :hourly, :daily])
    end
  end
  describe "::current_weather_data" do
    it "should return the desired weather information when given coordinates" do
      coords = {:lat=>39.738453, :lng=>-104.984853}
      info = WeatherService.get_city_info(coords)

      expect(info.class).to eq(Hash)
      expect(info.keys).to eq([:lat, :lon, :timezone, :timezone_offset, :current, :hourly, :daily])
    end
  end
end
