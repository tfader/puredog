class ClientsController < ApplicationController
  rescue_from 'ActiveRecord::InvalidForeignKey' do
    flash[:error] = 'Nie można usunąć danych, które zostały wykorzystane.'
    redirect_to clients_path
  end

  def autocomplete_client_name
    name = params[:term].upcase
    clients = Client.where(
        'upper(clients.name) LIKE ? or upper(clients.code) like ?',
        "%#{name}%", "%#{name}%"
    ).order(:name).all
    render :json => clients.map { |client| {:id => client.id, :label => client.name_with_city, :value => client.name_with_city} }
  end

  def index
    @where_you_are = 'Klienci'
    @clients = Client.all
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new
    @client.assign_attributes(client_params)
    @client.city = City.search_by_name(params[:client][:city_id])
    if @client.valid?
      @client.save
      redirect_to clients_path
    else
      flash[:error] = @client.errors.full_messages.first
      render 'new'
    end
  end

  def edit
    @client = Client.find(params[:id])
    @client.city_id = @client.city.name
  end

  def update
    @client = Client.find(params[:id])
    @client.assign_attributes(client_params)
    @client.city = City.search_by_name(params[:client][:city_id])
    if @client.valid?
      @client.save
      redirect_to clients_path
    else
      flash[:error] = @client.errors.full_messages.first
      render 'edit'
    end
  end

  private
  def client_params
    params.require(:client).permit(:code, :name, :street)
  end

end
