class SalariesFacade

  def self.final_city_info(location)
    city_info = {}
    city_info[:destination] = location
    city_info[:forecast] = city_forecast(location)
    city_info[:salaries] = SalaryService.city_salary_info(location)
    city_info
    final_city_info = OpenStruct.new(city_info)
  end

  def self.city_forecast(location)
    response = Faraday.get("https://api.teleport.org/api/urban_areas/slug:#{location}/")
    raw_data = JSON.parse(response.body, symbolize_names: true)
    coords = MapQuestService.coordinates(raw_data[:full_name])

    response = Faraday.get("https://api.openweathermap.org/data/2.5/onecall?lat=#{coords[:lat]}&lon=#{coords[:lng]}&exclude=alerts,minutely&appid=#{ENV['weather_api_key']}&units=imperial")
    raw_data = JSON.parse(response.body, symbolize_names: true)
    forecast = {}
    forecast[:summary] = raw_data[:current][:weather].first[:description]
    forecast[:temperature] = raw_data[:current][:temp]
    forecast
  end
end
