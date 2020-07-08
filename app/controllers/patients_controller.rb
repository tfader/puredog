class PatientsController < ApplicationController
  rescue_from 'ActiveRecord::InvalidForeignKey' do
    flash[:error] = 'Nie można usunąć danych, które zostały wykorzystane.'
    redirect_to patients_path
  end

  def index
    @where_you_are = 'Pacjenci'
    @patients = Patient.all
    @patient_attr = PatientAttr.all
  end

  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.new
    @patient.assign_attributes(patient_params)
    @patient.patron = Patron.search_by_id_or_second(params[:patient][:patron_id])
    @patient.variety = Variety.search_by_name(params[:patient][:variety_id])
    if @patient.valid?
      @patient.save
      redirect_to patients_path
    else
      flash[:error] = @patient.errors.full_messages.first
      render 'new'
    end
  end

  def edit
    @patient = Patient.find(params[:id])
    @patient.patron_id = @patient.patron.id_with_last_name if @patient.patron.present?
  end

  def update
    @patient = Patient.find(params[:id])
    @patient.assign_attributes(patient_params)
    if @patient.valid?
      @patient.save
      redirect_to patients_path
    else
      flash[:error] = @patient.errors.full_messages.first
      render 'new'
    end
  end

  def destroy
    @patient = Patient.find(params[:id])
    if @patient.patient_attr_values.delete_all
      if @patient.delete
        redirect_to patients_path
      else
        flash[:error] = @patient.errors.full_messages.first
        redirect_to patients_path
      end
    else
      flash[:error] = @patient.errors.full_messages.first
      redirect_to patients_path
    end
  end

  private
  def patient_params
    params.require(:patient).permit(:name)
  end

end
