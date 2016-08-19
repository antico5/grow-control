class Grow < ActiveRecord::Base
  has_many :readings

  def chart_data readings
    { created_at: readings.map { |reading| reading.created_at.to_formatted_s :short },
      temperatures: readings.pluck(:temperature),
      humidities: readings.pluck(:humidity) }
  end

  def readings_for_week week
    week -= 1
    from_date = start_date + week.weeks
    to_date = from_date + 1.week
    readings.where(created_at: from_date .. to_date)
      .select(:created_at, :temperature, :humidity)
  end


end
