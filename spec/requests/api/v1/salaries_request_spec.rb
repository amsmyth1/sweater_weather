require 'rails_helper'

RSpec.describe "Urban Area Salaries API Endpoint" do
  describe "happy path" do
    it "should return a city name, forecast, and salaries " do
      get "/api/v1/salaries?destination=philadelphia"
      exepect(response).to be_successful
      philly_info = JSON.parse(response.body, symbolize_names:true)

      expect(weather).to be_a(Hash)
      expect(weather[:data]).to be_a(Hash)
      expect(weather[:data].keys).to eq([:id, :type, :attributes])
      expect(weather[:data][:type]).to eq("salaries")
      expect(weather[:data][:attributes]).to be_a(Hash)
      expect(weather[:data][:attributes].keys).to eq([:destination, :forecast, :salaries])
      expect(weather[:data][:attributes][:destination]).to eq("philadelphia")
      expect(weather[:data][:attributes][:forecast]).to be_a(Hash)
      expect(weather[:data][:attributes][:forecast].keys).to eq([:summary, :temperature])
      expect(weather[:data][:attributes][:salaries]).to be_an(Array)
      expect(weather[:data][:attributes][:salaries].first).to be_a(Hash)
      expect(weather[:data][:attributes][:salaries].first.keys).to eq([:title, :min, :max])
      expect(weather[:data][:attributes][:salaries].first[:title]).to be_a(String)
      expect(weather[:data][:attributes][:salaries].first[:min]).to be_a(String)
      expect(weather[:data][:attributes][:salaries].first[:max]).to be_a(String)
      expect(weather[:data][:attributes][:salaries].count).to is_less_than_or_equal_to(7)
    end
  end
end
