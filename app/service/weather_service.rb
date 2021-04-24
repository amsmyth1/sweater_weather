class WeatherService

  def self.get_city_info(coords)
    response = Faraday.get("https://api.openweathermap.org/data/2.5/onecall?lat=#{coords[:lat]}&lon=#{coords[:lng]}&exclude=alerts,minutely&appid=#{ENV['weather_api_key']}&units=imperial")
    JSON.parse(response.body, symbolize_names: true)
    binding.pry
  end
end
