Rails.application.routes.draw do

  get "/api/v1/forecast", to: "api/v1/weather#forecast"
  get "api/v1/backgrounds", to:"api/v1/weather#photo"
end
