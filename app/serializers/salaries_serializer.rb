class SalariesSerializer
  include FastJsonapi::ObjectSerializer
  set_type :salaries
  set_id :id
  attributes  :destination, :forecast, :salaries
end
