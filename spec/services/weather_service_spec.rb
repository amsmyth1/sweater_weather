require 'rails_helper'

RSpec.describe "WeatherService", type: :feature do
  describe "::get_city_info(coords)" do
    describe "happy path" do
      it "should return the desired weather information when given coordinates" do
        VCR.use_cassette('forecast') do
          coords = {:lat=>39.738453, :lng=>-104.984853}
          info = WeatherService.get_city_info(coords)

          expect(info.class).to eq(Hash)
          expect(info.keys).to eq([:current_weather, :daily_weather, :hourly_weather, :photo_key_word])
          expect(info[:current_weather]).to be_a(Hash)
          expect(info[:current_weather].keys).to eq([:datetime, :sunrise, :sunset, :temperature, :feels_like, :humidity, :uvi, :visibility, :conditions, :icon])
          expect(info[:current_weather][:temperature]).to be_a(Float)
          expect(info[:current_weather][:feels_like]).to be_a(Float)
          expect(info[:current_weather][:humidity]).to be_a(Integer)
          expect(info[:current_weather][:uvi]).to be_a(Float)
          expect(info[:current_weather][:visibility]).to be_a(Integer)
          expect(info[:daily_weather]).to be_an(Array)
          expect(info[:daily_weather].count).to eq(5)
          expect(info[:daily_weather].first).to be_a(Hash)
          expect(info[:daily_weather].first.keys).to eq([:date, :sunrise, :sunset, :max_temp, :min_temp, :conditions, :icon])
          expect(info[:hourly_weather]).to be_an(Array)
          expect(info[:hourly_weather].count).to eq(8)
          expect(info[:hourly_weather].first).to be_a(Hash)
          expect(info[:hourly_weather].first.keys).to eq([:time, :temperature, :conditions, :icon])

          expect(info[:current_weather][:wind_gust]).to eq(nil)
          expect(info[:current_weather][:pressure]).to eq(nil)
          expect(info[:current_weather][:clouds]).to eq(nil)
          expect(info[:current_weather][:wind_deg]).to eq(nil)
        end
      end
    end
  end
end
