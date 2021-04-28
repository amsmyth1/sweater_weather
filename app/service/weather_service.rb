class WeatherService

  def self.one_call(coords)
    one_call = {}
    one_call[:photo_key_word] = get_city_info(coords)[:photo_key_word]
    weather_params = {}
    weather_params[:current_weather] = get_city_info(coords)[:current_weather]
    weather_params[:hourly_weather] = get_city_info(coords)[:hourly_weather]
    weather_params[:daily_weather] = get_city_info(coords)[:daily_weather]
    one_call[:weather] = weather_params
    one_call
  end

  def self.get_city_info(coords)
    response = Faraday.get("https://api.openweathermap.org/data/2.5/onecall?lat=#{coords[:lat]}&lon=#{coords[:lng]}&exclude=alerts,minutely&appid=#{ENV['weather_api_key']}&units=imperial")
    raw_data = JSON.parse(response.body, symbolize_names: true)
    city_info = {}
    city_info[:current_weather] = current_weather_data(raw_data)
    city_info[:daily_weather] = daily_weather_data(raw_data)
    city_info[:hourly_weather] = hourly_weather_data(raw_data)
    city_info[:photo_key_word] = current_weather_data(raw_data)[:conditions]
    city_info
  end

  def self.get_city_weather_by_future_time(coords, time)
    response = Faraday.get("https://api.openweathermap.org/data/2.5/onecall?lat=#{coords[:lat]}&lon=#{coords[:lng]}&exclude=alerts,minutely&appid=#{ENV['weather_api_key']}&units=imperial")
    raw_data = JSON.parse(response.body, symbolize_names: true)
    city_info = {}
    if time[0,2].to_i < 1
      city_info[:temperature] = raw_data[:current][:temp]
      city_info[:conditions] = raw_data[:current][:weather].first[:description]
    else time[0,2].to_i >= 1 && time[0,2].to_i < 49
      city_info[:temperature] = raw_data[:hourly][time[0,2].to_i][:temp]
      city_info[:conditions] = raw_data[:hourly][time[0,2].to_i][:weather].first[:description]
    end
    city_info
  end

  def self.daily_weather_data(raw_data)
    raw_data[:daily].first(5).map do |daily_raw_data|
      single_day_weather_data(daily_raw_data)
    end
  end

  def self.single_day_weather_data(raw_data)
    single_day_weather_data = {}
    single_day_weather_data[:date] = Time.at(raw_data[:dt])
    single_day_weather_data[:sunrise] = Time.at(raw_data[:sunrise])
    single_day_weather_data[:sunset] = Time.at(raw_data[:sunset])
    single_day_weather_data[:max_temp] = raw_data[:temp][:max]
    single_day_weather_data[:min_temp] = raw_data[:temp][:min]
    single_day_weather_data[:conditions] = raw_data[:weather].first[:description]
    single_day_weather_data[:icon] = raw_data[:weather].first[:icon]
    single_day_weather_data
  end

  def self.hourly_weather_data(raw_data)
    raw_data[:hourly].first(8).map do |hourly_raw_data|
      hour_weather_data(hourly_raw_data)
    end
  end

  def self.hour_weather_data(raw_data)
    hour_weather_data = {}
    t = Time.at(raw_data[:dt])
    hour_weather_data[:time] = "#{t.hour}:00:00"
    hour_weather_data[:temperature] = raw_data[:temp]
    hour_weather_data[:conditions] = raw_data[:weather].first[:description]
    hour_weather_data[:icon] = raw_data[:weather].first[:icon]
    hour_weather_data
  end



  def self.current_weather_data(raw_data)
    current_weather_data = {}
    current_weather_data[:datetime] = Time.at(raw_data[:current][:dt])
    current_weather_data[:sunrise] = Time.at(raw_data[:current][:sunrise])
    current_weather_data[:sunset] = Time.at(raw_data[:current][:sunset])
    current_weather_data[:temperature] = raw_data[:current][:temp]
    current_weather_data[:feels_like] = raw_data[:current][:feels_like]
    current_weather_data[:humidity] = raw_data[:current][:humidity]
    current_weather_data[:uvi] = raw_data[:current][:uvi]
    current_weather_data[:visibility] = raw_data[:current][:visibility]
    current_weather_data[:conditions] = raw_data[:current][:weather].first[:description]
    current_weather_data[:icon] = raw_data[:current][:weather].first[:icon]
    current_weather_data
  end
end
