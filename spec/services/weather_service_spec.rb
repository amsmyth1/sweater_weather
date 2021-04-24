require 'rails_helper'

RSpec.describe "WeatherService", type: :feature do
  describe "::weather_data" do
    it "should return the desired weather information when given coordinates" do
      coords = {:lat=>39.738453, :lng=>-104.984853}
      info = WeatherService.get_info(coords)

      expect(1).to eq(info)
    end
  end
end
