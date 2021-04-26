require 'rails_helper'

RSpec.describe "Urban Area Salaries API Endpoint" do
  describe "happy path" do
    it "should return a city name, forecast, and salaries " do
      get "/api/v1/salaries?destination=philadelphia"
      expect(response).to be_successful
      philly_info = JSON.parse(response.body, symbolize_names:true)

      expect(philly_info).to be_a(Hash)
      expect(philly_info[:data]).to be_a(Hash)
      expect(philly_info[:data].keys).to eq([:id, :type, :attributes])
      expect(philly_info[:data][:type]).to eq("salaries")
      expect(philly_info[:data][:attributes]).to be_a(Hash)
      expect(philly_info[:data][:attributes].keys).to eq([:destination, :forecast, :salaries])
      expect(philly_info[:data][:attributes][:destination]).to eq("philadelphia")

      expect(philly_info[:data][:attributes][:salaries]).to be_an(Array)
      expect(philly_info[:data][:attributes][:salaries].first).to be_a(Hash)
      expect(philly_info[:data][:attributes][:salaries].first.keys).to eq([:title, :min, :max])
      expect(philly_info[:data][:attributes][:salaries].first[:title]).to be_a(String)
      expect(philly_info[:data][:attributes][:salaries].first[:min]).to be_a(String)
      expect(philly_info[:data][:attributes][:salaries].first[:max]).to be_a(String)
      expect(philly_info[:data][:attributes][:forecast]).to be_a(Hash)
      expect(philly_info[:data][:attributes][:forecast].keys).to eq([:summary, :temperature])
    end
  end
end
