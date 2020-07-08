class PatientAttrsController < ApplicationController
  rescue_from 'ActiveRecord::InvalidForeignKey' do
    flash[:error] = 'Nie można usunąć danych, które zostały wykorzystane.'
    redirect_to patient_attrs_path
  end

  def index
    @where_you_are = 'Atrybuty pacjentów'
    @patient_attrs = PatientAttr.all
  end

  def new
    @patient_attr = PatientAttr.new
  end

  def create
    @patient_attr = PatientAttr.new
    @patient_attr.assign_attributes(patient_attr_params)
    if @patient_attr.valid?
      @patient_attr.save
      redirect_to patient_attrs_path
    else
      flash[:error] = @patient_attr.errors.full_messages.first
      render 'new'
    end
  end

  def destroy
    patient_attr = PatientAttr.find(params[:id])
    if patient_attr.delete
      redirect_to patient_attrs_path
    else
      flash[:error] = patient_attr.errors.full_messages.first
      redirect_to patient_attrs_path
    end

  end

  private
  def patient_attr_params
    params.require(:patient_attr).permit(:attr_id, :mandatory)
  end

end
