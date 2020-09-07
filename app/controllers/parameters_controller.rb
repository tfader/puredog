class ParametersController < ApplicationController
  def index
    @parameters = Parameter.all.order(:param_name)
  end

  def new
    @parameter = Parameter.new
  end

  def create
    @parameter = Parameter.new
    @parameter.assign_attributes(parameter_params)
    if @parameter.valid?
      @parameter.save
      redirect_to parameters_path
    else
      flash[:error] = @parameter.errors.full_messages.first
      render 'new'
    end
  end

  def edit
    @parameter = Parameter.find(params[:id])
  end

  def update
    @parameter = Parameter.find(params[:id])
    @parameter.assign_attributes(parameter_params)
    if @parameter.valid?
      @parameter.save
      redirect_to parameters_path
    else
      flash[:error] = @parameter.errors.full_messages.first
      render 'edit'
    end
  end

  private
  def parameter_params
    params.require(:parameter).permit(:param_name, :value_type, :param_value)
  end
end
