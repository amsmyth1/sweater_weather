class SalariesFacade

  def self.location_check?(location)
    if SalaryService.search_ua_id(location) == nil
      false
    else
      true
    end
  end

  def self.final_city_info(location)
    city_info = {}
    city_info[:destination] = location
    city_info[:forecast] = city_forecast(location)
    city_info[:salaries] = SalaryService.city_salary_info(location)
    city_info
    final_city_info = OpenStruct.new(city_info)
  end

  def self.city_forecast(location)
    coords = MapQuestService.coordinates(SalaryService.full_name(location))
    weather = WeatherService.get_city_info(coords)
    forecast = {}
    forecast[:summary] = weather[:current_weather][:conditions]
    forecast[:temperature] = weather[:current_weather][:temperature]
    forecast
  end
end
