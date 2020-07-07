class SpotsController < ApplicationController
  rescue_from 'ActiveRecord::InvalidForeignKey' do
    flash[:error] = 'Nie można usunąć danych, które zostały wykorzystane.'
    redirect_to spots_path
  end

  def index
    @spots = Spot.all
  end

  def new
    @spot = Spot.new
  end

  def create
    @spot = Spot.new
    @spot.assign_attributes(spot_params)
    if @spot.valid?
      @spot.save
      redirect_to spots_path
    else
      flash[:error] = @spot.errors.full_messages.first
      render 'new'
    end
  end

  def edit
    @spot = Spot.find(params[:id])
  end

  def update
    @spot = Spot.find(params[:id])
    @spot.assign_attributes(spot_params)
    if @spot.valid?
      @spot.save
      redirect_to spots_path
    else
      flash[:error] = @spot.errors.full_messages.first
      render 'edit'
    end
  end

  private
  def spot_params
    params.require(:spot).permit(:city_id, :name, :street)
  end
end
