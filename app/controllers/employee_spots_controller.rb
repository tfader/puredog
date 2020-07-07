class EmployeeSpotsController < ApplicationController

  rescue_from 'ActiveRecord::InvalidForeignKey' do
    flash[:error] = 'Nie można usunąć danych, które zostały wykorzystane.'
    redirect_to employees_path
  end

  def new
    if Spot.count == 0
      flash[:error] = 'Lista nie zawiera żadnych elementów'
      redirect_to employees_path
    else
      @employee = Employee.find(params[:employee_id])
      @employee_spot = EmployeeSpot.new(:date_from => DateTime.now.to_date.beginning_of_month, :date_to => Parameter.get_value('default_date_to'))
    end
  end

  def create
    @employee_spot = EmployeeSpot.new
    @employee = Employee.find(params[:employee_id])
    spot = Spot.find(params[:employee_spot][:spot_id])
    @employee_spot.assign_attributes(:employee => @employee, :spot => spot, :date_from => params[:employee_spot][:date_from], :date_to => params[:employee_spot][:date_to])
    if @employee_spot.valid?
      @employee_spot.save
      redirect_to employees_path
    else
      flash[:error] = @employee_spot.errors.full_messages.first
      render 'new'
    end
  end
end
