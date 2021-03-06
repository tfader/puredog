class UnitsController < ApplicationController
  rescue_from 'ActiveRecord::InvalidForeignKey' do
    flash[:error] = 'Nie można usunąć danych, które zostały wykorzystane.'
    redirect_to units_path
  end

  def autocomplete_unit_name(p_exam = nil)
    name = params[:term].upcase
    units = Unit.where(
        'upper(units.name) LIKE ? or upper(units.code) like ?',
        "%#{name}%", "%#{name}%"
    ).order(:code).all
    render :json => units.map { |unit| {:id => unit.id, :label => unit.name_with_code, :value => unit.name_with_code} }
  end

  def index
    @where_you_are = 'Jednostki'
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
