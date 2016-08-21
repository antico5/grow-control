class Grow < ActiveRecord::Base
  has_many :readings

  def chart_data readings
    { timestamps: readings.map { |reading| reading.created_at.to_formatted_s :short },
      temperatures: readings.pluck(:temperature),
      humidities: readings.pluck(:humidity) }
  end

  def readings_for_week index
    readings_for :week, index
  end

  def readings_for_day index
    readings_for :day, index
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

  def readings_for time_unit, index
    index -= 1
    from_date = start_date + index.send(time_unit)
    to_date = from_date + 1.send(time_unit)
    readings.where(created_at: from_date .. to_date)
      .select(:created_at, :temperature, :humidity)
      .order(:created_at)
  end
end
