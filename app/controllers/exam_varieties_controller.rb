class ExamVarietiesController < ApplicationController
  rescue_from 'ActiveRecord::InvalidForeignKey' do
    flash[:error] = 'Nie można usunąć danych, które zostały wykorzystane.'
    redirect_to exams_path
  end

  def index
    @exam = Exam.find(params[:exam_id])
    @where_you_are = 'Badania dla '+@exam.name
    @exam_varieties = @exam.exam_varieties.all
  end

  def new
    @exam = Exam.find(params[:exam_id])
    @exam_variety = ExamVariety.new(:exam => @exam)
    @varieties = Variety
                     .where('id not in (select variety_id from exam_varieties where exam_id = ?)', @exam.id)
                     .all
    if @varieties.count == 0
      flash[:error] = 'Pusta lista.'
      redirect_to exam_exam_varieties_path(@exam)
    end
  end

  def create
    @exam = Exam.find(params[:exam_id])
    @exam_variety = ExamVariety.new
    @exam_variety.assign_attributes(:exam => @exam, :variety => Variety.find(params[:exam_variety][:variety_id]))
    if @exam_variety.valid?
      @exam_variety.save
      redirect_to exam_exam_varieties_path(@exam)
    else
      flash[:error] = @exam_variety.errors.full_messages.first
      render 'new'
    end

    def destroy
      @exam = Exam.find(params[:exam_id])
      @exam_variety = ExamVariety.find(params[:id])
      if @exam_variety.delete
        redirect_to exam_exam_varieties_path(@exam)
      else
        flash[:error] = @exam_variety.errors.full_messages.first
        redirect_to exam_exam_varieties_path(@exam)
      end
    end
  end

end
