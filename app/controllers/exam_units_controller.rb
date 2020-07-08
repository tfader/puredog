class ExamUnitsController < ApplicationController

  rescue_from 'ActiveRecord::InvalidForeignKey' do
    flash[:error] = 'Nie można usunąć danych, które zostały wykorzystane.'
    redirect_to exams_path
  end

  def index
    @exam = Exam.find(params[:exam_id])
    @where_you_are = 'Jednostki dla '+@exam.name
    @exam_units = @exam.exam_units.all
  end

  def new
    @exam = Exam.find(params[:exam_id])
    @exam_unit = ExamUnit.new(:exam => @exam)
    @units = Unit
                     .where('id not in (select unit_id from exam_units where exam_id = ?)', @exam.id)
                     .all
    if @units.count == 0
      flash[:error] = 'Pusta lista.'
      redirect_to exam_exam_units_path(@exam)
    end
  end

  def create
    @exam = Exam.find(params[:exam_id])
    @exam_unit = ExamUnit.new
    @exam_unit.assign_attributes(:exam => @exam, :unit => Unit.find(params[:exam_unit][:unit_id]), :is_default => params[:exam_unit][:is_default])
    if @exam_unit.valid?
      @exam_unit.save
      redirect_to exam_exam_units_path(@exam)
    else
      flash[:error] = @exam_unit.errors.full_messages.first
      render 'new'
    end
  end

  def destroy
    @exam = Exam.find(params[:exam_id])
    @exam_unit = ExamUnit.find(params[:id])
    if @exam_unit.delete
      redirect_to exam_exam_units_path(@exam)
    else
      flash[:error] = @exam_unit.errors.full_messages.first
      redirect_to exam_exam_units_path(@exam)
    end
  end

end
