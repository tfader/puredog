class ExamGroupsController < ApplicationController

  rescue_from 'ActiveRecord::InvalidForeignKey' do
    flash[:error] = 'Nie można usunąć danych, które zostały wykorzystane.'
    redirect_to exam_groups_path
  end

  def autocomplete_exam_group_name
    name = params[:term].upcase
    exam_groups = ExamGroup.where(
        'upper(exam_groups.name) LIKE ?',
        "%#{name}%"
    ).order(:name).all
    render :json => exam_groups.map { |exam_group| {:id => exam_group.id, :label => exam_group.name, :value => exam_group.name} }
  end

  def index
    @where_you_are = 'Grupy badań'
    @exam_groups = ExamGroup.all.order(:name)
    if params[:exam_group_id].present?
      @exam_group = ExamGroup.find(params[:exam_group_id])
      @exam_group_exams = @exam_group.exam_group_exams.all
    end
  end

  def new
    @exam_group = ExamGroup.new
  end

  def create
    @exam_group = ExamGroup.new
    @exam_group.assign_attributes(exam_group_params)
    if @exam_group.valid?
      @exam_group.save
      redirect_to exam_groups_path
    else
      flash[:error] = @exam_group.errors.full_messages.first
      render 'new'
    end
  end

  def edit
    @exam_group = ExamGroup.find(params[:id])
  end

  def update
    @exam_group = ExamGroup.find(params[:id])
    @exam_group.assign_attributes(exam_group_params)
    if @exam_group.valid?
      @exam_group.save
      redirect_to exam_groups_path
    else
      flash[:error] = @exam_group.errors.full_messages.first
      render 'edit'
    end
  end

  def destroy
    @exam_group = ExamGroup.find(params[:id])
    @exam_group.delete
    redirect_to exam_groups_path
  end

  private
  def exam_group_params
    params.require(:exam_group).permit( :name)
  end
  
end
