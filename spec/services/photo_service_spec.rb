require 'rails_helper'

RSpec.describe "PhotoService", type: :feature do
  describe "::search" do
    it "returns a photo of the queried city" do
      photos = PhotoService.search("denver,co")

      expect(photos.class).to eq(OpenStruct)
      expect(photos[:location]).to eq("denver,co")
      expect(photos[:image_url]).to be_a(String)
      expect(photos[:credit]).to be_a(Hash)
      expect(photos[:credit].keys).to eq([:source, :author, :logo])
    end
  end
end
