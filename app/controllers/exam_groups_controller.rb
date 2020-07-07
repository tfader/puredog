class ExamGroupsController < ApplicationController

  rescue_from 'ActiveRecord::InvalidForeignKey' do
    flash[:error] = 'Nie można usunąć danych, które zostały wykorzystane.'
    redirect_to exam_groups_path
  end

  def index
    @exam_groups = ExamGroup.all.order(:name)
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

  private
  def exam_group_params
    params.require(:exam_group).permit( :name)
  end
  
end
