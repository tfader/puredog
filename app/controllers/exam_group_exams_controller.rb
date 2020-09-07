class ExamGroupExamsController < ApplicationController
  def index
    @exam_group = ExamGroup.find(params[:exam_group_id])
    @exam_group_exams = @exam_group.exam_group_exams.all
  end

  def new
    @exam_group = ExamGroup.find(params[:exam_group_id])
    @exam_group_exam = ExamGroupExam.new
    @exams = Exam
                 .where('id not in (select exam_id from exam_group_exams where exam_group_id = ?)', @exam_group.id)
                 .all
  end

  def create
    @exam_group = ExamGroup.find(params[:exam_group_id])
    @exam_group_exam = ExamGroupExam.new
    @exam_group_exam.exam_group = @exam_group
    @exam_group_exam.exam = Exam.find(params[:exam_group_exam][:exam_id])
    @exam_group_exam.save
    redirect_to exam_groups_path(:exam_group_id => @exam_group.id)
  end

  def destroy
    @exam_group = ExamGroup.find(params[:exam_group_id])
    @exam_group_exam = ExamGroupExam.find(params[:id])
    @exam_group_exam.delete
    redirect_to exam_groups_path(:exam_group_id => @exam_group.id)
  end
end
