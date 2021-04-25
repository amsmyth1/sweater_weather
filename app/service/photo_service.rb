class PhotoService

  def self.search(location)
    response = Faraday.get("https://api.unsplash.com/search/photos/?Accept-Version=v1&client_id=_#{ENV['photo_api_key']}&query=#{location}")
    raw_data = JSON.parse(response.body, symbolize_names: true)

    if raw_data[:results].empty?
      []
    else
      photo = raw_data[:results].sample
      background = {}
      image = {}
      image[:location] = location
      image[:image_url] = photo[:urls][:full]
      credit = {}
      credit[:source] = "unsplash.com"
      credit[:author] = photo[:user][:name]
      credit[:logo] = photo[:user][:profile_image][:small]
      image[:credit] = credit
      background[:image] = image
      # OpenStruct.new(background)
      background
    end
  end
end
