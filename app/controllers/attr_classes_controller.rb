class AttrClassesController < ApplicationController
  rescue_from 'ActiveRecord::InvalidForeignKey' do
    flash[:error] = 'Nie można usunąć danych, które zostały wykorzystane.'
    redirect_to attr_classes_path
  end

  def index
    @where_you_are = 'Grupy atrybutów'
    @attr_classes = AttrClass.all.order(:name)
  end

  def new
    @attr_class = AttrClass.new
  end

  def create
    @attr_class = AttrClass.new
    @attr_class.assign_attributes(attr_class_params)
    if @attr_class.valid?
      @attr_class.save
      redirect_to attr_classes_path
    else
      flash[:error] = @attr_class.errors.full_messages.first
      render 'new'
    end
  end

  def edit
    @attr_class = AttrClass.find(params[:id])
  end

  def update
    @attr_class = AttrClass.find(params[:id])
    @attr_class.assign_attributes(attr_class_params)
    if @attr_class.valid?
      @attr_class.save
      redirect_to attr_classes_path
    else
      flash[:error] = @attr_class.errors.full_messages.first
      render 'new'
    end
  end

  private
  def attr_class_params
    params.require(:attr_class).permit(:name, :value_type)
  end
end
