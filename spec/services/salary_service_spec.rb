require 'rails_helper'

RSpec.describe "SalaryService", type: :feature do
  describe "::search_ua_id - happy path" do
    it "hits an endpoint to get the city urban id" do
      VCR.use_cassette('salary-service-happy') do
        urban_id = SalaryService.search_ua_id("denver")

        expect(urban_id).to eq("9xj65")
      end
    end
  end
  describe "::search_ua_id - sad path" do
    it "hits an endpoint to get the city urban id" do
      VCR.use_cassette('salary-service-sad') do
        urban_id = SalaryService.search_ua_id("jasndvjhasd")

        expect(urban_id).to eq(nil)
      end
    end
  end
  describe "::full_name(location) - happy path" do
    it "hits an endpoint to get the city urban id" do
      VCR.use_cassette('salary-service-happy') do
        full_name = SalaryService.full_name("denver")

        expect(full_name).to eq("Denver, Colorado")
      end
    end
  end
  describe "::full_name(location) - sad path" do
    it "hits an endpoint to get the city urban id" do
      VCR.use_cassette('salary-service-sad') do
        urban_id = SalaryService.search_ua_id("jasndvjhasd")

        expect(urban_id).to eq(nil)
      end
    end
  end
  describe "::city_all_salary_info(location) - happy" do
    it "hits an endpoint to get the city urban id" do
      VCR.use_cassette('salary-service-all-happy') do
        info = SalaryService.city_all_salary_info("denver")

        expect(info).to be_an(Array)
        expect(info.first).to be_a(Hash)
        expect(info.first.keys).to eq([:title, :min, :max])
      end
    end
  end
  describe "::city_all_salary_info(location) - sad" do
    it "hits an endpoint to get the city urban id" do
      VCR.use_cassette('salary-service-all-sad') do
        info = SalaryService.city_all_salary_info("jhancjasnc")

        expect(info).to eq(nil)
      end
    end
  end
  describe "::salary_info(salary)" do
    it "hits an endpoint to get the city urban id" do
      VCR.use_cassette('salary-service-info-one') do
        info = (SalaryService.city_all_salary_info("denver")).first

        expect(info).to be_a(Hash)
        expect(info.keys).to eq([:title, :min, :max])
        expect(info[:title]).to eq("Account Manager")
        expect(info[:min]).to be_a(String)
        expect(info[:max]).to be_a(String)
      end
    end
  end
  describe "::city_salary_info(location)" do
    it "hits an endpoint to get the city urban id" do
      VCR.use_cassette('salary-service-info-two') do
        info = SalaryService.city_salary_info("denver")

        expect(info).to be_an(Array)
        expect(info.count).to be_between(0, 7).inclusive
      end
    end
  end
end
