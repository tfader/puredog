class PriceListsController < ApplicationController

  def index
    @where_you_are = 'Cenniki'
    @price_lists = PriceList.all.order(:client_id)
  end

  def new
    @price_list = PriceList.new
  end

  def create
    @price_list = PriceList.new
    @price_list.assign_attributes(price_list_params)
    @price_list.client = Client.search_by_id_or_second(params[:price_list][:client_id])
    if @price_list.valid?
      @price_list.save
      redirect_to price_lists_path
    else
      flash[:error] = @price_list.errors.full_messages.first
      render 'new'
    end
  end

  def edit
    @price_list = PriceList.find(params[:id])
  end

  def update
    @price_list = PriceList.find(params[:id])
    @price_list.assign_attributes(price_list_params)
    @price_list.client = Client.search_by_id_or_second(params[:price_list][:client_id])
    if @price_list.valid?
      @price_list.save
      redirect_to price_lists_path
    else
      flash[:error] = @price_list.errors.full_messages.first
      render 'edit'
    end
  end

  def destroy
    price_list = PriceList.find(params[:id])
    if price_list.price_list_items.delete_all
      price_list.delete
      redirect_to price_lists_path
    end
  end

  def add_all
    if Parameter.get_value('price_by_group') == 0
      exams = Exam.all
      price_list = PriceList.find(params[:price_list_id])
      exams.each do |exam|
        if price_list.price_list_items.find_by(exam_id: exam.id).blank?
          PriceListItem.create(:price_list => price_list, :exam => exam, :price => Parameter.get_value('default_exam_price'), :is_cito => price_list.is_cito)
        end
      end
    else
      exam_groups = ExamGroup.all
      price_list = PriceList.find(params[:price_list_id])
      exam_groups.each do |exam_group|
        if price_list.price_list_items.find_by(exam_group_id: exam_group.id).blank?
          PriceListItem.create(:price_list => price_list, :exam_group => exam_group, :price => Parameter.get_value('default_exam_price'), :is_cito => price_list.is_cito)
        end
      end
    end
    redirect_to price_list_price_list_items_path(price_list)
  end

  private
  def price_list_params
    params.require(:price_list).permit( :exam, :is_cito, :is_general )
  end
end
