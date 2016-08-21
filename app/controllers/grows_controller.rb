class GrowsController < ApplicationController
  before_action :set_grow, only: [:show, :edit, :update, :destroy, :period_count, :chart_data]

  # GET /grows
  def index
    @grows = Grow.all
  end

  # GET /grows/1
  def show
  end

  # GET /grows/new
  def new
    @grow = Grow.new
  end

  # GET /grows/1/edit
  def edit
  end

  # POST /grows
  def create
    @grow = Grow.new(grow_params)

    if @grow.save
      redirect_to @grow, notice: 'Grow was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /grows/1
  def update
    if @grow.update(grow_params)
      redirect_to @grow, notice: 'Grow was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /grows/1
  def destroy
    @grow.destroy
    redirect_to grows_url, notice: 'Grow was successfully destroyed.'
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
    # Use callbacks to share common setup or constraints between actions.
    def set_grow
      @grow = Grow.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def grow_params
      params.require(:grow).permit(:name, :start_date)
    end
end
