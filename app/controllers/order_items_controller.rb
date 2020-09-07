class OrderItemsController < ApplicationController
  rescue_from 'ActiveRecord::InvalidForeignKey' do
    flash[:error] = 'Nie można usunąć danych, które zostały wykorzystane.'
    redirect_to exams_path
  end

  def new
    @order = Order.find(params[:order_id])
    @order_item = OrderItem.new(:order => @order, :is_cito => @order.is_cito)
    if params[:patient_id].present?
      @order_item.patient_id = Patient.find(params[:patient_id]).name_with_patron_name
    end
  end

  def create
    @order = Order.find(params[:order_id])
    @order_item = OrderItem.new
    @order_item.order = @order
    if Parameter.get_value('multiple_patient_on_order') == 1
      @order_item.patient = Patient.search_by_patron_and_name(params[:order_item][:patient_id])
      @order_item.exam = Exam.search_by_name(params[:order_item][:exam_id])
    else
      @order_item.exam_group = ExamGroup.search_by_name(params[:order_item][:exam_group_id])
    end

    @order_item.is_cito = params[:order_item][:is_cito]

    if @order_item.valid?
      @order_item.save
      @order_item.exam_group.exam_group_exams.each do |exam_group_exam|
        OrderItemResult.create(:order_item => @order_item, :exam => exam_group_exam.exam, :unit => exam_group_exam.exam.default_unit)
      end
      redirect_to order_path(@order)
    else
      flash[:error] = 'Błąd podczas dodawania - '+@order_item.errors.full_messages.first
      redirect_to order_path(@order)
    end
  end

  def edit
    @order = Order.find(params[:order_id])
    @order_item = OrderItem.find(params[:id])
  end

  def update
    @order = Order.find(params[:order_id])
    @order_item = OrderItem.find(params[:id])
    params[:order_item_results].each do |order_item_result|
      OrderItemResult
          .find(order_item_result[0])
          .update(:result => order_item_result[1]['result'])
      @order.update(:order_status => OrderStatus.find_by_name('in_progress'))
    end
    redirect_to order_path(@order)
  end

  def destroy
    order = Order.find(params[:order_id])
    order_item = OrderItem.find(params[:id])
    if order_item.order_item_results.delete_all
      if order_item.delete
        redirect_to order_path(order)
      else
        flash[:error] = 'Błąd podczas usuwania - '+@order_item.errors.full_messages.first
        redirect_to order_path(order)
      end
    else
      flash[:error] = 'Błąd podczas usuwania - '+@order_item.errors.full_messages.first
      redirect_to order_path(order)
    end
  end
end
