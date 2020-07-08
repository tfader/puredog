class OrderStatusesController < ApplicationController
  rescue_from 'ActiveRecord::InvalidForeignKey' do
    flash[:error] = 'Nie można usunąć danych, które zostały wykorzystane.'
    redirect_to order_statuses_path
  end

  def autocomplete_order_status_name
    name = params[:term].upcase
    order_statuses = OrderStatus.where(
        'upper(order_statuses.name) LIKE ?',
        "%#{name}%"
    ).order(:name).all
    render :json => order_statuses.map { |order_status| {:id => order_status.id, :label => order_status.name, :value => order_status.name} }
  end

  def index
    @where_you_are = 'Statusy zleceń'
    @order_statuses = OrderStatus.all.order(:name)
  end

  def new
    if OrderFlow.count == 0
      flash[:error] = 'Pusta lista'
      redirect_to order_statuses_path
    else
      @order_status = OrderStatus.new
    end
  end

  def create
    @order_status = OrderStatus.new
    @order_status.assign_attributes(order_status_params)
    if @order_status.valid?
      @order_status.save
      redirect_to order_statuses_path
    else
      flash[:error] = @order_status.errors.full_messages.first
      render 'new'
    end
  end

  def edit
    @order_status = OrderStatus.find(params[:id])
  end

  def update
    @order_status = OrderStatus.find(params[:id])
    @order_status.assign_attributes(order_status_params)
    if @order_status.valid?
      @order_status.save
      redirect_to order_statuses_path
    else
      flash[:error] = @order_status.errors.full_messages.first
      render 'edit'
    end
  end

  def destroy
    order_status = OrderStatus.find(params[:id])
    if order_status.delete
      redirect_to order_statuses_path
    else
      flash[:error] = order_status.errors.full_messages.first
      redirect_to order_statuses_path
    end

  end

  private
  def order_status_params
    params.require(:order_status).permit( :name, :order_flow_id)
  end
end
