class PriceListItemsController < ApplicationController

  def index
    @price_list = PriceList.find(params[:price_list_id])
    if Parameter.get_value('price_by_group') == 0
      @price_list_items = @price_list.price_list_items.joins(:exam).order('exams.name').order('price_list_items.is_cito').all
    else
      @price_list_items = @price_list.price_list_items.joins(:exam_group).order('exam_groups.name').order('price_list_items.is_cito').all
    end
  end
  
  def new
    @price_list = PriceList.find(params[:price_list_id])
    @price_list_item = PriceListItem.new(:price_list => @price_list)
  end

  def create
    @price_list = PriceList.find(params[:price_list_id])
    @price_list_item = PriceListItem.new
    @price_list_item.price_list = @price_list
    if Parameter.get_value('price_by_group') == 0
      @price_list_item.exam = Exam.search_by_name(params[:price_list_item][:exam_id])
    else
      @price_list_item.exam_group = ExamGroup.search_by_name(params[:price_list_item][:exam_group_id])
    end
    @price_list_item.is_cito = params[:price_list_item][:is_cito]
    @price_list_item.price = params[:price_list_item][:price]
    if @price_list_item.valid?
      @price_list_item.save
      redirect_to price_list_price_list_items_path(@price_list)
    else
      flash[:error] = 'Błąd podczas dodawania - '+@price_list_item.errors.full_messages.first
      redirect_to price_list_price_list_items_path(@price_list)
    end
  end

  def edit
    @price_list = PriceList.find(params[:price_list_id])
    @price_list_item = PriceListItem.find(params[:id])
  end


  def update
    @price_list = PriceList.find(params[:price_list_id])
    @price_list_item = PriceListItem.find(params[:id])
    @price_list_item.price_list = @price_list
    @price_list_item.exam = Exam.search_by_name(params[:price_list_item][:exam_id])
    @price_list_item.is_cito = params[:price_list_item][:is_cito]
    @price_list_item.price = params[:price_list_item][:price]
    if @price_list_item.valid?
      @price_list_item.save
      redirect_to price_list_price_list_items_path(@price_list)
    else
      flash[:error] = 'Błąd podczas aktualizacji - '+@price_list_item.errors.full_messages.first
      redirect_to price_list_price_list_items_path(@price_list)
    end
  end

  def destroy
    price_list = PriceList.find(params[:price_list_id])
    price_list_item = PriceListItem.find(params[:id])
    if price_list_item.delete
      redirect_to price_list_price_list_items_path(price_list)
    else
      flash[:error] = 'Błąd podczas usuwania - '+price_list_item.errors.full_messages.first
      redirect_to price_list_price_list_items_path(price_list)
    end
  end
  
end
