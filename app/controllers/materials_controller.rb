class MaterialsController < ApplicationController
  rescue_from 'ActiveRecord::InvalidForeignKey' do
    flash[:error] = 'Nie można usunąć danych, które zostały wykorzystane.'
    redirect_to materials_path
  end

  def index
    @where_you_are = 'Materiały'
    @materials = Material.all
  end

  def new
    @material = Material.new
  end

  def create
    @material = Material.new
    @material.assign_attributes(material_params)
    if @material.valid?
      @material.save
      redirect_to materials_path
    else
      flash[:error] = @material.errors.full_messages.first
      render 'new'
    end
  end

  def edit
    @material = Material.find(params[:id])
  end

  def update
    @material = Material.find(params[:id])
    @material.assign_attributes(material_params)
    if @material.valid?
      @material.save
      redirect_to materials_path
    else
      flash[:error] = @material.errors.full_messages.first
      render 'edit'
    end
  end

  private
  def material_params
    params.require(:material).permit( :name)
  end
end
