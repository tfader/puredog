class ExamsController < ApplicationController
  rescue_from 'ActiveRecord::InvalidForeignKey' do
    flash[:error] = 'Nie można usunąć danych, które zostały wykorzystane.'
    redirect_to exams_path
  end

  def index
    @where_you_are = 'Badania'
    @exams = Exam.all
  end

  def new
    @exam = Exam.new
  end

  def create
    @exam = Exam.new
    @exam.assign_attributes(exam_params)
    if @exam.valid?
      @exam.save
      redirect_to exams_path
    else
      flash[:error] = @exam.errors.full_messages.first
      render 'new'
    end
  end

  def edit
    @exam = Exam.find(params[:id])
  end

  def update
    @exam = Exam.find(params[:id])
    @exam.assign_attributes(exam_params)
    if @exam.valid?
      @exam.save
      redirect_to exams_path
    else
      flash[:error] = @exam.errors.full_messages.first
      render 'edit'
    end
  end

  private
  def exam_params
    params.require(:exam).permit( :name, :exam_group_id, :material_id, :description)
  end
end