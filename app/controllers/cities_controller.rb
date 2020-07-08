class CitiesController < ApplicationController

  rescue_from 'ActiveRecord::InvalidForeignKey' do
    flash[:error] = 'Nie można usunąć danych, które zostały wykorzystane.'
    redirect_to cities_path
  end

  def autocomplete_city_name
    name = params[:term].upcase
    cities = City.where(
        'upper(cities.name) LIKE ?',
        "%#{name}%"
    ).order(:name).all
    render :json => cities.map { |city| {:id => city.id, :label => city.name, :value => city.name} }
  end

  def index
    @where_you_are = 'Miejscowości'
    @cities = City.all.order(:name)
  end

  def new
    @city = City.new
  end

  def create
    @city = City.new
    @city.assign_attributes(city_params)
    if @city.valid?
      @city.save
      redirect_to cities_path
    else
      flash[:error] = @city.errors.full_messages.first
      render 'new'
    end
  end

  def edit
    @city = City.find(params[:id])
  end

  def update
    @city = City.find(params[:id])
    @city.assign_attributes(city_params)
    if @city.valid?
      @city.save
      redirect_to cities_path
    else
      flash[:error] = @city.errors.full_messages.first
      render 'edit'
    end
  end

  private
  def city_params
    params.require(:city).permit( :name, :file_icon)
  end

end
