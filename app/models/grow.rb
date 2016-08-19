class Grow < ActiveRecord::Base
  has_many :readings

  def reading_data_for_chart
    selected_readings = readings.select(:created_at, :temperature, :humidity).limit 168
    labels = selected_readings.map {|reading| reading.created_at.to_formatted_s :short }
    values = selected_readings.map &:temperature
    { labels: labels, values: values }
  end

end
