class MapQuestService

  def self.coordinates(location)
    response = Faraday.get("http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['mapquest_api_key']}&location=#{location}")
    raw_coordinate_data = JSON.parse(response.body, symbolize_names: true)
    if raw_coordinate_data[:info][:statuscode] == 400
      coordinates = {:lat=>39.738453, :lng=>-104.984853}
    else
      coordinates = raw_coordinate_data[:results].first[:locations].first[:latLng]
      # location_data = {
      #   lat: coordinates[:lat],
      #   lng: coordinates[:lng],
      #   city: "#{raw_coordinate_data[:results].first[:locations].first[:adminArea5]}",
      #   state: "#{raw_coordinate_data[:results].first[:locations].first[:adminArea5]}"}
      # Location.create(location_data)
    end
    coordinates
  end
end
