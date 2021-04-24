require 'rails_helper'

RSpec.describe "MapQuestService", type: :feature do
  describe "::coordinates" do
    it "should return a hash with the lat and lng values" do
      coords = MapQuestService.coordinates("denver,co")
      answer = {:lat=>39.738453, :lng=>-104.984853}

      expect(answer).to eq(coords)
    end

  end
end
