class ExamAttrsController < ApplicationController
  rescue_from 'ActiveRecord::InvalidForeignKey' do
    flash[:error] = 'Nie można usunąć danych, które zostały wykorzystane.'
    redirect_to exam_attrs_path
  end

  def index
    @where_you_are = 'Atrybuty badań'
    @exam_attrs = ExamAttr.all
  end

  def new
    @exam_attr = ExamAttr.new
  end

  def create
    @exam_attr = ExamAttr.new
    @exam_attr.assign_attributes(exam_attr_params)
    if @exam_attr.valid?
      @exam_attr.save
      redirect_to exam_attrs_path
    else
      flash[:error] = @exam_attr.errors.full_messages.first
      render 'new'
    end
  end

  def destroy
    exam_attr = ExamAttr.find(params[:id])
    if exam_attr.delete
      redirect_to exam_attrs_path
    else
      flash[:error] = exam_attr.errors.full_messages.first
      redirect_to exam_attrs_path
    end

  end

  private
  def exam_attr_params
    params.require(:exam_attr).permit(:attr_id, :mandatory)
  end
end
