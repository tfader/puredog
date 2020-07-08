class UnitRatesController < ApplicationController

  def index
    @where_you_are = 'Przeliczniki'
    @unit = Unit.find(params[:unit_id])
    @unit_rates = @unit.rates_from.all
  end

  def new
    @unit = Unit.find(params[:unit_id])
    @unit_rate = UnitRate.new
    @units_to = Unit
                    .where('id != ?',@unit.id)
                    .where('id not in (select to_unit_id from unit_rates where from_unit_id = ?)', @unit.id)
                    .all
                    .order(:name)
    if @units_to.count == 0
      flash[:error] = 'Pusta lista'
      redirect_to unit_unit_rates_path(@unit)
    end
  end

  def create
    @unit = Unit.find(params[:unit_id])
    @unit_rate = UnitRate.new
    @unit_rate.assign_attributes(:from_unit => @unit, :to_unit => Unit.find(params[:unit_rate][:unit_to_id]), :rate_from => params[:unit_rate][:rate_from], :rate_to => params[:unit_rate][:rate_to])
    if @unit_rate.valid?
      @unit_rate.save
      redirect_to unit_unit_rates_path(@unit)
    else
      flash[:error] = @unit_rate.errors.full_messages.first
      render 'new'
    end
  end
end
