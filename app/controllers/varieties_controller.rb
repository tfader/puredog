class VarietiesController < ApplicationController
  rescue_from 'ActiveRecord::InvalidForeignKey' do
    flash[:error] = 'Nie można usunąć danych, które zostały wykorzystane.'
    redirect_to varieties_path
  end

  def index
    @varieties = Variety.all.order(:name)
  end

  def new
    @variety = Variety.new
  end

  def create
    @variety = Variety.new
    @variety.assign_attributes(variety_params)
    if @variety.valid?
      @variety.save
      redirect_to varieties_path
    else
      flash[:error] = @variety.errors.full_messages.first
      render 'new'
    end
  end

  def edit
    @variety = Variety.find(params[:id])
  end

  def update
    @variety = Variety.find(params[:id])
    @variety.assign_attributes(variety_params)
    if @variety.valid?
      @variety.save
      redirect_to varieties_path
    else
      flash[:error] = @variety.errors.full_messages.first
      render 'edit'
    end
  end

  private
  def variety_params
    params.require(:variety).permit( :name, :file_icon)
  end
end
