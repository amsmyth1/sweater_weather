class UserErrorSerializer
  def as_json(_options = nil)
    {
      error: "a field is not correct"
    }
  end
end
