class OrderItemResultsController < ApplicationController

  def new
    @order_item = OrderItem.find(params[:order_item_id])
    @order = @order_item.order
    @order_item_result = OrderItemResult.new
  end

  def create
    @order_item = OrderItem.find(params[:order_item_id])
    @order_item_result = OrderItemResult.new(:order_item => @order_item)
    @order_item_result.assign_attributes(order_item_result_params)
    @order_item_result.unit = Unit.search_by_code_or_name(params[:order_item_result][:unit_id])
    if @order_item_result.valid?
      @order_item_result.save
      @order_item.order.update(:order_status => OrderStatus.find_by_name('in_progress'))
      redirect_to order_path(@order_item.order)
    else
      flash[:error] = 'Błąd podczas dodawnia - '+@order_item_result.errors.full_messages.first
      redirect_to order_path(@order_item.order)
    end
  end

  private
  def order_item_result_params
    params.require(:order_item_result).permit(:order_item, :result)
  end
end
