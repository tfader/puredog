class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  helper_method :current_employee

  def current_employee
    if current_user.present?
      emp_user = EmployeeUser.find_by(user_id: current_user.id)
      if emp_user.present?
        if Employee.find_by_id(emp_user.employee_id).active == 1
          Employee.find_by_id(emp_user.employee_id)
        else
          false
        end
      else
        false
      end
    end
  end

end
