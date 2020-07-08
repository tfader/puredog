class StationsController < ApplicationController
  rescue_from 'ActiveRecord::InvalidForeignKey' do
    flash[:error] = 'Nie można usunąć danych, które zostały wykorzystane.'
    redirect_to spots_path
  end

  def index
    @spot = Spot.find(params[:spot_id])
    @stations = @spot.stations.all
    @where_you_are = 'Stanowiska w placówce - '+@spot.name
  end

  def new
    @spot = Spot.find(params[:spot_id])
    @station = Station.new
  end

  def create
    @spot = Spot.find(params[:spot_id])
    @station = Station.new
    @station.assign_attributes(station_params)
    @station.spot = @spot
    if @station.valid?
      @station.save
      redirect_to spot_stations_path(@spot)
    else
      flash[:error] = @station.errors.full_messages.first
      render 'new'
    end
  end

  def edit
    @spot = Spot.find(params[:spot_id])
    @station = Station.find(params[:id])
  end

  def update
    @spot = Spot.find(params[:spot_id])
    @station = Station.find(params[:id])
    @station.assign_attributes(station_params)
    @station.spot = @spot
    if @station.valid?
      @station.save
      redirect_to spot_stations_path(@spot)
    else
      flash[:error] = @station.errors.full_messages.first
      render 'edit'
    end
  end

  def destroy
    spot = Spot.find(params[:spot_id])
    station = Station.find(params[:id])
    if station.delete
      redirect_to spot_stations_path(spot)
    end
  end

  private
  def station_params
    params.require(:station).permit(:name)
  end


end
