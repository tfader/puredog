class EmployeeUsersController < ApplicationController

  rescue_from 'ActiveRecord::InvalidForeignKey' do
    flash[:error] = 'Nie można usunąć danych, które zostały wykorzystane.'
    redirect_to employees_path
  end

  def new
    if User.where('id not in (select user_id from employee_users)').count == 0
      flash[:error] = 'Lista nie zawiera żadnych elementów'
      redirect_to employees_path
    else
      @employee = Employee.find(params[:employee_id])
      @employee_user = EmployeeUser.new
    end
  end

  def create
    @employee_user = EmployeeUser.new
    @employee = Employee.find(params[:employee_id])
    user = User.find(params[:employee_user][:user_id])
    @employee_user.assign_attributes(:employee => @employee, :user => user)
    if @employee_user.valid?
      @employee_user.save
      redirect_to employees_path
    else
      flash[:error] = @employee_user.errors.full_messages.first
      render 'new'
    end
  end
end
