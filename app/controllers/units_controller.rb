class UnitsController < ApplicationController
  rescue_from 'ActiveRecord::InvalidForeignKey' do
    flash[:error] = 'Nie można usunąć danych, które zostały wykorzystane.'
    redirect_to units_path
  end

  def index
    @units = Unit.all.order(:name)
  end

  def new
    @unit = Unit.new
  end

  def create
    @unit = Unit.new
    @unit.assign_attributes(unit_params)
    if @unit.valid?
      @unit.save
      redirect_to units_path
    else
      flash[:error] = @unit.errors.full_messages.first
      render 'new'
    end
  end

  def edit
    @unit = Unit.find(params[:id])
  end

  def update
    @unit = Unit.find(params[:id])
    @unit.assign_attributes(unit_params)
    if @unit.valid?
      @unit.save
      redirect_to units_path
    else
      flash[:error] = @unit.errors.full_messages.first
      render 'edit'
    end
  end

  private
  def unit_params
    params.require(:unit).permit( :name, :code)
  end
end
