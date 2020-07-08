class PatientAttrValuesController < ApplicationController

  def new
    @attr = Attr.find(params[:attr_id])
    @patient = Patient.find(params[:patient_id])
    @patient_attr_value = PatientAttrValue.new(:attr => @attr, :patient => @patient)
  end

  def create
    @attr = Attr.find(params[:attr_id])
    @patient = Patient.find(params[:patient_id])
    @patient_attr_value = PatientAttrValue.new
    @patient_attr_value.assign_attributes(:attr => @attr, :patient => @patient, :attr_value => params[:patient_attr_value][:attr_value])
    if @patient_attr_value.valid?
      @patient_attr_value.save
      redirect_to patients_path
    else
      flash[:error] = @patient_attr_value.errors.full_messages.first
      render 'new'
    end
  end

  def edit
    @attr = Attr.find(params[:attr_id])
    @patient = Patient.find(params[:patient_id])
    @patient_attr_value = PatientAttrValue.find(params[:id])
  end

  def update
    @attr = Attr.find(params[:attr_id])
    @patient = Patient.find(params[:patient_id])
    @patient_attr_value = PatientAttrValue.find(params[:id])
    @patient_attr_value.assign_attributes(:attr => @attr, :patient => @patient, :attr_value => params[:patient_attr_value][:attr_value])
    if @patient_attr_value.valid?
      @patient_attr_value.save
      redirect_to patients_path
    else
      flash[:error] = @patient_attr_value.errors.full_messages.first
      render 'edit'
    end
  end
end
