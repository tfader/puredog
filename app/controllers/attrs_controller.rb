class AttrsController < ApplicationController

  rescue_from 'ActiveRecord::InvalidForeignKey' do
    flash[:error] = 'Nie można usunąć danych, które zostały wykorzystane.'
    redirect_to root_path
  end

  def index
    @attr_class = AttrClass.find(params[:attr_class_id])
    @where_you_are = 'Atrybuty w klasie '+@attr_class.name
    @attributes = @attr_class.attrs.all
  end

  def new
    @attr_class = AttrClass.find(params[:attr_class_id])
    @attr = Attr.new(:attr_class => @attr_class, :value_type => @attr_class.value_type)
  end

  def create
    @attr_class = AttrClass.find(params[:attr_class_id])
    @attr = Attr.new
    @attr.assign_attributes(:attr_class => @attr_class, :name => params[:attr][:name], :value_type => params[:attr][:value_type])
    if @attr.valid?
      @attr.save
      redirect_to attr_class_attrs_path(@attr_class)
    else
      flash[:error] = @attr.errors.full_messages.first
      render 'new'
    end
  end

  def edit
    @attr_class = AttrClass.find(params[:attr_class_id])
    @attr = Attr.find(params[:id])
  end

  def update
    @attr_class = AttrClass.find(params[:attr_class_id])
    @attr = Attr.find(params[:id])
    @attr.assign_attributes(:attr_class => @attr_class, :name => params[:attr][:name], :value_type => params[:attr][:value_type])
    if @attr.valid?
      @attr.save
      redirect_to attr_class_attrs_path(@attr_class)
    else
      flash[:error] = @attr.errors.full_messages.first
      render 'new'
    end
  end

  def destroy
    attr_class = AttrClass.find(params[:attr_class_id])
    attr = Attr.find(params[:id])
    if attr.present?
      if attr.delete
        redirect_to attr_class_attrs_path(attr_class)
      else
        flash[:error] = attr.errors.full_messages.first
      end
    end
  end

end
