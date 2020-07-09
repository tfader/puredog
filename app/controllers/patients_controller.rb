class PatientsController < ApplicationController
  rescue_from 'ActiveRecord::InvalidForeignKey' do
    flash[:error] = 'Nie można usunąć danych, które zostały wykorzystane.'
    redirect_to patients_path
  end

  def autocomplete_patient_name
    name = params[:term].upcase
    patients = Patient.where(
        'upper(patients.name) LIKE ? or exists (select null from patrons where patients.patron_id = patrons.id and (patrons.public_id like ? or upper(patrons.last_name) like ?))',
        "%#{name}%", "%#{name}%", "%#{name}%"
    ).order(:id).all
    render :json => patients.map { |patient| {:id => patient.id, :label => patient.name_with_patron_name, :value => patient.name_with_patron_name} }
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
  end

  def update
    @patient = Patient.find(params[:id])
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
