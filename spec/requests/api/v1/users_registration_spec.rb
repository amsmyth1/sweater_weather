require 'rails_helper'

RSpec.describe "User Registration API Endpoint" do
  describe "user registration happy path" do
    it "creates and new user and returns their email and new api key when they are successfully registered" do
      user_params = ({
                      email: "host_eamil@domain.com",
                      password_digest: "password",
                      password_confirmation: "password"
                    })
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/users", headers: headers, params: JSON.generate(user_params)
      created_user = User.last

      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(response.body).to eq(1)
      expect(created_user.email).to eq(user_params[:email])
    end
  end
  xdescribe "user registration sad path" do
    it "creates and new user and returns their email and new api key when they are successfully registered" do
      user_params = ({
                      email: "host_eamil@domain.com",
                      password_digest: "password",
                      password_confirmation: ""
                    })
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/users", headers: headers, params: JSON.generate(user_params)
      created_user = User.last

      expect(response).to be_successful
      expect(response.status).to eq(400)
    end
  end
end
