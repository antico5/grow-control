class Reading < ActiveRecord::Base
  validates :humidity, :temperature, numericality: true
  validates :grow_name, length: {in: 1..50}
end
