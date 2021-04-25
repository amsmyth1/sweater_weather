class UserRegistrationErrorSerializer
  def as_json(_options = nil)
    {
      error: "email is associated with an account"
    }
  end
end
