require 'rails_helper'

RSpec.describe "PhotoService", type: :feature do
  describe "::search" do
    describe "happy path" do
      it "returns a photo of the queried city" do
        photos = PhotoService.search("denver,co")

        expect(photos.class).to eq(OpenStruct)
        expect(photos[:image][:location]).to eq("denver,co")
        expect(photos[:image][:image_url]).to be_a(String)
        expect(photos[:image][:credit]).to be_a(Hash)
        expect(photos[:image][:credit].keys).to eq([:source, :author, :logo])
      end
    end
    describe "sad path" do
      it "returns " do

      end
    end 
  end
end