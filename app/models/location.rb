class Location < ApplicationRecord
  validates :lat, presence: true, numericality: {
           greater_than_or_equal_to: 0
         }
  validates :lng, presence: true, numericality: {
           greater_than_or_equal_to: 0
         }
  validates_presence_of :city
end
