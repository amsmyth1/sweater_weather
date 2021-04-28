class MapQuestService

  def self.coordinates(location)
    response = Faraday.get("http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['mapquest_api_key']}&location=#{location}")
    raw_coordinate_data = JSON.parse(response.body, symbolize_names: true)
    if raw_coordinate_data[:info][:statuscode] == 400
      coordinates = {:lat=>39.738453, :lng=>-104.984853}
    else
      coordinates = raw_coordinate_data[:results].first[:locations].first[:latLng]
    end
    coordinates
  end

  def self.trip_duration(origin, destination)
    response = Faraday.get("http://www.mapquestapi.com/directions/v2/route?key=#{ENV['mapquest_api_key']}&from=#{origin}&to=#{destination}")
    raw_data = JSON.parse(response.body, symbolize_names: true)
    time = raw_data[:route][:formattedTime]
  end
end
