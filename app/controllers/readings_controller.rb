class ReadingsController < ApplicationController
  before_action :set_grow
  skip_before_action :verify_authenticity_token

  def index
    @readings = @grow.readings.order(:created_at => 'desc').limit 300
    @last_reading = @readings.last
    @chart_data_endpoint = chart_data_grow_path(@grow)
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

  def chart_data
    if params[:periodicity] == 'weekly'
      render json: @grow.chart_data(@grow.readings_for_week params[:index].to_i)
    else
      render nothing: true
    end
  end

  def period_count
    case params[:periodicity]
    when 'weekly'
      render json: @grow.total_weeks
    when 'daily'
      render json: @grow.total_days
    else
      render nothing: true, status: 404
    end
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
