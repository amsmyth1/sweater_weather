Rails.application.routes.draw do

  get "/api/v1/forecast", to: "api/v1/weather#forecast"
  get "/api/v1/backgrounds", to:"api/v1/weather#photo"
  post "/api/v1/users", to:"api/v1/users#register"

  get "/api/v1/salaries", to:"api/v1/salaries#city_info"
end
