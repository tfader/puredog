class OrdersController < ApplicationController
  rescue_from 'ActiveRecord::InvalidForeignKey' do
    flash[:error] = 'Nie można usunąć danych, które zostały wykorzystane.'
    redirect_to orders_path
  end

  def new
    @order = Order.new
    @order.order_status = Order.first_step_status
    @order_items = @order.order_items.all
    @session_id = session.id
  end

  def index
    @where_you_are = 'Zlecenia'
    @orders = Order.all.order(:id)
  end

  def create
    @order = Order.new
    @order.assign_attributes(order_params)
    @order.client = Client.search_by_id_or_second(params[:order][:client_id])
    @order.order_status = Order.first_step_status
    @order.spot = current_employee.current_spot
    if @order.valid?
      @order.save
      redirect_to order_path(@order)
    else
      flash[:error] = @order.errors.full_messages.first
      render 'new'
    end
  end

  def show
    @order = Order.find(params[:id])
    @order_status_id = @order.order_status.name
  end

  def destroy
    order = Order.find(params[:id])
    if order.delete
      redirect_to orders_path
    end
  end

  def change_status
    order = Order.find(params[:order_id])
    order_status = OrderStatus.find_by_name(params[:new_status])
    if order_status.present?
      order.update(:order_status => order_status)
    else
      flash[:error] = 'Bład aktualizacji statusu #err1'
      redirect_to order_path(order)
    end
    redirect_to order_path(order)
  end

  private
  def order_params
    params.require(:order).permit(:placed, :ordered, )
  end

end
