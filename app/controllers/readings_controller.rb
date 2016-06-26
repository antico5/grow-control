class ReadingsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @readings = Reading.order :created_at => 'desc'
    @last_reading = Reading.last
  end

  def create
    last_reading_time = Reading.last.try :created_at || 0
    if Time.now - last_reading_time >= 10.minutes
    	Reading.create! permitted_params
    end
    render nothing: true, status: 200
  rescue
    FailedReading.create! permitted_params
    render nothing: true, status: 400
  end

  def permitted_params
    params.permit :grow_name, :humidity, :temperature
  end
end
