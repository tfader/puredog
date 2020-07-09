class OrderItemsController < ApplicationController
  def new
    @order = Order.find(params[:order_id])
    @order_item = OrderItem.new(:order => @order)
    if params[:patient_id].present?
      @order_item.patient_id = Patient.find(params[:patient_id]).name_with_patron_name
    end
  end

  def create
    @order = Order.find(params[:order_id])
    @order_item = OrderItem.new
    @order_item.order = @order
    @order_item.patient = Patient.search_by_patron_and_name(params[:order_item][:patient_id])
    @order_item.exam = Exam.search_by_name(params[:order_item][:exam_id])
    if @order_item.valid?
      @order_item.save
      redirect_to order_path(@order)
    else
      flash[:error] = 'Błąd podczas dodawania - '+@order_item.errors.full_messages.first
      redirect_to order_path(@order)
    end
  end

  def destroy
    order = Order.find(params[:order_id])
    order_item = OrderItem.find(params[:id])
    if order_item.delete
      redirect_to order_path(order)
    else
      flash[:error] = 'Błąd podczas usuwania - '+@order_item.errors.full_messages.first
      redirect_to order_path(order)
    end
  end

end
