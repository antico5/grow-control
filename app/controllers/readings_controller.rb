class ReadingsController < ApplicationController
  before_action :set_grow
  skip_before_action :verify_authenticity_token

  def index
    @last_reading = @grow.readings.last
  end

  def create
    last_reading_time = @grow.readings.last.try(:created_at) || Time.at(0)
    if Time.now - last_reading_time >= 60.minutes
      @grow.readings.create! permitted_params
    end
    render nothing: true, status: 200
  rescue
    FailedReading.create! permitted_params
    render nothing: true, status: 400
  end

  private

  def permitted_params
    params.permit :humidity, :temperature
  end

  def set_grow
    if params[:grow_id]
      @grow = Grow.find params[:grow_id]
    else
      @grow = Grow.find_by_name 'default'
    end
  end
end
