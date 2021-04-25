require 'rails_helper'

RSpec.describe "MapQuestService", type: :feature do
  describe "::coordinates" do
    describe "happy path" do
      it "should return a hash with the lat and lng values" do
        coords = MapQuestService.coordinates("denver,co")
        answer = {:lat=>39.738453, :lng=>-104.984853}

        expect(answer).to eq(coords)
      end
    end
    describe "sad path - bad city" do
      it "should return a hash by default when a bad city is passed" do
        coords = MapQuestService.coordinates("usnfjkasdnc")
        answer = {:lat=>39.390897, :lng=>-99.066067}

        expect(answer).to eq(coords)
      end
    end
    describe "sad path - no city" do
      it "should return a hash by default when a bad city is passed" do
        coords = MapQuestService.coordinates("")
          answer = {:lat=>39.738453, :lng=>-104.984853}

        expect(answer).to eq(coords)
      end
    end
  end
end
