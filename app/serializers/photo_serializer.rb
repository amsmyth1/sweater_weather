class PhotoSerializer
  include FastJsonapi::ObjectSerializer
  set_type :image
  attributes  :image
  set_id :id
end
