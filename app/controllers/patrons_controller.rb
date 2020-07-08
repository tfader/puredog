class PatronsController < ApplicationController
  rescue_from 'ActiveRecord::InvalidForeignKey' do
    flash[:error] = 'Nie można usunąć danych, które zostały wykorzystane.'
    redirect_to patrons_path
  end

  def autocomplete_patron_name
    name = params[:term].upcase
    patrons = Patron.where(
        'upper(patrons.last_name) LIKE ? OR upper(patrons.public_id) LIKE ?',
        "%#{name}%", "%#{name}%"
    ).order(:id).all
    render :json => patrons.map { |patron| {:id => patron.id, :label => patron.id_with_names, :value => patron.id_with_names} }
  end

  def index
    @where_you_are = 'Patroni'
    @patrons = Patron.all.order(:last_name)
  end

  def new
    @patron = Patron.new
  end

  def create
    @patron = Patron.new
    @patron.assign_attributes(patron_params)
    if @patron.valid?
      @patron.save
      redirect_to patrons_path
    else
      flash[:error] = @patron.errors.full_messages.first
      render 'new'
    end
  end

  def edit
    @patron = Patron.find(params[:id])
  end

  def update
    @patron = Patron.find(params[:id])
    @patron.assign_attributes(patron_params)
    if @patron.valid?
      @patron.save
      redirect_to patrons_path
    else
      flash[:error] = @patron.errors.full_messages.first
      render 'new'
    end
  end

  def destroy
    @patron = Patron.find(params[:id])
    if @patron.delete
      redirect_to patrons_path
    else
      flash[:error] = @patron.errors.full_messages.first
      redirect_to patrons_path
    end
  end

  private
  def patron_params
    params.require(:patron).permit(:first_name, :last_name, :public_id)
  end
end
