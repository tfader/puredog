class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  before_action :set_locale

  helper_method :current_employee

  @where_you_are = 'Strona główna'

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

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

end
