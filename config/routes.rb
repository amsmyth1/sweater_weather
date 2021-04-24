Rails.application.routes.draw do

  get "/api/v1/forecast", to: "weather#forecast"
  get "api/v1/backgrounds", to:"weather#photo"
end
