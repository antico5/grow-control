class ReadingsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @readings = Reading.order :created_at
  end

  def create
    Reading.create! permitted_params
    render nothing: true, status: 200
  rescue
    FailedReading.create! permitted_params
    render nothing: true, status: 400
  end

  def permitted_params
    params.permit :grow_name, :humidity, :temperature
  end
end
