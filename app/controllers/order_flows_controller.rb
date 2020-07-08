class OrderFlowsController < ApplicationController

  rescue_from 'ActiveRecord::InvalidForeignKey' do
    flash[:error] = 'Nie można usunąć danych, które zostały wykorzystane.'
    redirect_to order_flows_path
  end

  def autocomplete_order_flow_name
    name = params[:term].upcase
    order_flows = OrderFlow.where(
        'upper(order_flows.name) LIKE ?',
        "%#{name}%"
    ).order(:flow_step).all
    render :json => order_flows.map { |order_flow| {:id => order_flow.id, :label => order_flow.name, :value => order_flow.name} }
  end

  def index
    @where_you_are = 'Etapy realizacji zleceń'
    @order_flows = OrderFlow.all.order(:flow_step)
  end

  def new
    @order_flow = OrderFlow.new
  end

  def create
    @order_flow = OrderFlow.new
    @order_flow.assign_attributes(order_flow_params)
    if @order_flow.valid?
      @order_flow.save
      redirect_to order_flows_path
    else
      flash[:error] = @order_flow.errors.full_messages.first
      render 'new'
    end
  end

  def edit
    @order_flow = OrderFlow.find(params[:id])
  end

  def update
    @order_flow = OrderFlow.find(params[:id])
    @order_flow.assign_attributes(order_flow_params)
    if @order_flow.valid?
      @order_flow.save
      redirect_to order_flows_path
    else
      flash[:error] = @order_flow.errors.full_messages.first
      render 'edit'
    end
  end

  private
  def order_flow_params
    params.require(:order_flow).permit( :name, :flow_step)
  end
  
end
