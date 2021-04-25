class PhotoService

  def self.search(location)
    response = Faraday.get("https://api.unsplash.com/search/photos/?Accept-Version=v1&client_id=_#{ENV['photo_api_key']}&query=#{location}")
    raw_data = JSON.parse(response.body, symbolize_names: true)
    photo = raw_data[:results].sample
    background = {}
    background[:image_url] = photo[:urls][:full]
    background[:location] = location
    credit = {}
    credit[:source] = "unsplash.com"
    credit[:author] = photo[:user][:name]
    credit[:logo] = photo[:user][:profile_image][:small]
    background[:credit] = credit
    background
  end
end
