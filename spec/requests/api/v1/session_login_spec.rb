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
      post "/api/v1/sessions"

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

    xit "finds an existing user if emails matches and returns their email and stored api key when they try to reregister" do
      user_params = ({
        email: "whatever@example.com",
        password: "password",
        password_confirmation: "password"
      })
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/users", headers: headers, params: JSON.generate(user_params)
      @created_user = User.last

      user_params = ({
        email: "whatever@example.com",
        password: "password",
        password_confirmation: "password"
      })
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/users", headers: headers, params: JSON.generate(user_params)
      @created_user = User.last

      expect(response.status).to eq(400)
      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:error]).to eq("a field is not correct")
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
      @created_user = User.last

      expect(response.status).to eq(400)
      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:error]).to eq("a field is not correct")
    end
  end
end
