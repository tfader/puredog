class EmployeesController < ApplicationController
  rescue_from 'ActiveRecord::InvalidForeignKey' do
    flash[:error] = 'Nie można usunąć danych, które zostały wykorzystane.'
    redirect_to employees_path
  end

  def index
    @employees = Employee.all
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new
    @employee.assign_attributes(employee_params)
    if @employee.valid?
      @employee.save
      redirect_to employees_path
    else
      flash[:error] = @employee.errors.full_messages.first
      render 'new'
    end
  end

  def edit
    @employee = Employee.find(params[:id])
  end

  def update
    @employee = Employee.find(params[:id])
    @employee.assign_attributes(employee_params)
    if @employee.valid?
      @employee.save
      redirect_to employees_path
    else
      flash[:error] = @employee.errors.full_messages.first
      render 'edit'
    end
  end

  private
  def employee_params
    params.require(:employee).permit(:first_name, :second_name, :last_name)
  end

end
