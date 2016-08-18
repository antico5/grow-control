class Reading < ActiveRecord::Base
  belongs_to :grow

  validates :humidity, :temperature, numericality: true
end
