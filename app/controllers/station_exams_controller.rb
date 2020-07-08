class StationExamsController < ApplicationController
  rescue_from 'ActiveRecord::InvalidForeignKey' do
    flash[:error] = 'Nie można usunąć danych, które zostały wykorzystane.'
    redirect_to spots_path
  end

  def index
    @spot = Spot.find(params[:spot_id])
    @station = Station.find(params[:station_id])
    @station_exams = @station.station_exams.all
    @where_you_are = 'Badania na stanowisku - '+@station.name
  end

  def new
    @spot = Spot.find(params[:spot_id])
    @station = Station.find(params[:station_id])
    @station_exam = StationExam.new
    @exams = Exam.where('not exists (select null from station_exams where station_exams.station_id = ? and station_exams.exam_id = exams.id)', @station.id).all
  end

  def create
    @spot = Spot.find(params[:spot_id])
    @station = Station.find(params[:station_id])
    @station_exam = StationExam.new
    @station_exam.station = @station
    @station_exam.exam = Exam.find(params[:station_exam][:exam_id])
    if @station_exam.valid?
      @station_exam.save
      redirect_to spot_station_station_exams_path(@spot, @station)
    else
      flash[:error] = @station_exam.errors.full_messages.first
      render 'new'
    end
  end

  def destroy
    spot = Spot.find(params[:spot_id])
    station = Station.find(params[:station_id])
    station_exam = StationExam.find(params[:id])
    if station_exam.delete
      redirect_to spot_station_station_exams_path(spot, station)
    else
      flash[:error] = station_exam.errors.full_messages.first
      redirect_to spot_station_station_exams_path(spot, station)
    end
  end

end
