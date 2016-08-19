class Grow < ActiveRecord::Base
  has_many :readings

  def chart_data readings
    { timestamps: readings.map { |reading| reading.created_at.to_formatted_s :short },
      temperatures: readings.pluck(:temperature),
      humidities: readings.pluck(:humidity) }
  end

  def readings_for_week week
    index = week - 1
    from_date = start_date + index.weeks
    to_date = from_date + 1.week
    readings.where(created_at: from_date .. to_date)
      .select(:created_at, :temperature, :humidity)
  end

  def total_weeks
    (time_elapsed / 604800).ceil
  end

  def total_days
    (time_elapsed / 86400).ceil
  end

  private

  def time_elapsed
    last_reading = readings.maximum :created_at
    first_reading = readings.minimum :created_at
    (last_reading - first_reading).to_f
  end
end
