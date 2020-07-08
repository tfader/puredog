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

  private
  def patient_params
    params.require(:patient).permit(:name, :variety_id)
  end

end
