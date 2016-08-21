class GrowsController < ApplicationController
  before_action :set_grow, only: [:show, :edit, :update, :destroy, :period_count, :chart_data]

  def index
    @grows = Grow.all
  end

  def show
    @last_reading = @grow.readings.last
  end

  def new
    @grow = Grow.new
  end

  def edit
  end

  def create
    @grow = Grow.new(grow_params)

    if @grow.save
      redirect_to @grow, notice: 'Grow was successfully created.'
    else
      render :new
    end
  end

  def update
    if @grow.update(grow_params)
      redirect_to @grow, notice: 'Grow was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @grow.destroy
    redirect_to grows_url, notice: 'Grow was successfully destroyed.'
  end

  def chart_data
    case params[:periodicity]
    when 'weekly'
      render json: @grow.chart_data(@grow.readings_for_week params[:index].to_i)
    when 'daily'
      render json: @grow.chart_data(@grow.readings_for_day params[:index].to_i)
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
    # Use callbacks to share common setup or constraints between actions.
    def set_grow
      @grow = Grow.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def grow_params
      params.require(:grow).permit(:name, :start_date)
    end
end
