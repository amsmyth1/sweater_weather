require 'rails_helper'

RSpec.describe "User Registration API Endpoint" do
  describe "user registration happy path" do
    it "creates and new user and returns their email and new api key when they are successfully registered" do
      user_params = ({
                      email: "host_eamil@domain.com",
                      password_digest: "password"
                    })
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/users", headers: headers, params: JSON.generate(user_params)
      created_user = User.last

      expect(response).to be_successful
      expect(created_user.email).to eq(user_params[:email])
    end
  end
end
