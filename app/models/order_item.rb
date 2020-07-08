class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :patient
  belongs_to :exam


  def is_duplicate(p_id = self.id, p_patient_id = self.patient_id, p_exam_id = self.exam_id)
    if OrderItem
           .where('patient_id = ?', p_patient_id)
           .where('exam_id = ?', p_exam_id)
           .where('id != ?', p_id).where('order_id = ?', self.order_id)
           .count > 0
      true
    else
      false
    end
  end

  def station_name
    station_exam = StationExam
        .where('exam_id = ?', exam_id)
        .where('exists (select null from stations where stations.id = station_exams.station_id and stations.spot_id = ?)', order.spot_id).first
    if station_exam.present?
      station_exam.station.name
    else
      'Nie przypisane'
    end
  end

end
