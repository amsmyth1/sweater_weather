require 'rails_helper'

RSpec.describe "User Login API Endpoint" do
  before :each do
    user_params = ({
      email: "whatever@example.com",
      password: "password",
      password_confirmation: "password"
    })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/users", headers: headers, params: JSON.generate(user_params)
    @created_user = User.last
  end

  describe "user session happy path" do
    it "returns a confirmed user and their email and api key when they are successfully authenticated" do
      user_params = ({
        email: "whatever@example.com",
        password: "password"
      })
      headers = {"CONTENT_TYPE" => "application/json"}
      post "/api/v1/sessions", headers: headers, params: JSON.generate(user_params)

      data = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(data[:id]).to eq("#{@created_user.id}")
      expect(data[:type]).to eq("users")
      expect(data[:attributes]).to be_a(Hash)
      expect(data[:attributes][:email]).to eq(user_params[:email])
      expect(data[:attributes][:api_key]).to eq(@created_user.api_key)
      expect(data[:attributes][:password]).to eq(nil)
      expect(data[:attributes][:password_digest]).to eq(nil)
      expect(data[:attributes][:password_confirmation]).to eq(nil)
    end
  end
  describe "user registration sad path" do
    it "creates and new user and returns their email and new api key when they are successfully registered" do
      user_params = ({
        email: "whatever@example.com",
        password: "incorrect_password"
      })
      headers = {"CONTENT_TYPE" => "application/json"}
      post "/api/v1/sessions", headers: headers, params: JSON.generate(user_params)

      expect(response.status).to eq(401)
      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:error]).to eq("a field is not correct")
    end
  end
  describe "user registration edge cas - no body path" do
    it "creates and new user and returns their email and new api key when they are successfully registered" do
      user_params = ({email: "whatever@example.com"})
      headers = {"CONTENT_TYPE" => "application/json"}
      post "/api/v1/sessions", headers: headers, params: JSON.generate(user_params)

      expect(response.status).to eq(401)
      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:error]).to eq("a field is not correct")
    end
  end
end
