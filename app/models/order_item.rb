class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :patient
  belongs_to :exam
  has_many :order_item_results


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
    end
  end

  def show_results
    if order_item_results.present?
      v_results_array = []
      order_item_results.all.order(:result_time).each do |order_item_result|
        v_results_array.push(order_item_result.result)
      end
      v_results = v_results_array.join(' / ')
    else
      v_results = 'Brak'
    end
    v_results
  end

  def last_result
    if order_item_results.present?
      v_last_result = order_item_results.all.order(:result_time).last
    else
      v_last_result = nil
    end
    v_last_result
  end

  def result_mark
    v_ret = 0
    v_last_result = last_result
    if v_last_result.present?
      if exam.exam_units.present?
        exam_unit = exam.exam_units.find_by(exam_id: exam.id)
        if exam_unit.present?
          v_norm_min = exam_unit.norm_min
          v_norm_max = exam_unit.norm_max
          if v_norm_min.present?
            if v_last_result.result < v_norm_min
              v_ret = -1
            end
          end
          if v_norm_max.present?
            if v_last_result.result > v_norm_max
              v_ret = 1
            end
          end
        end
      end
    else
      v_ret = nil
    end
    v_ret
  end

  def item_price
    v_price = 0
    if order.is_cito == 1 or is_cito == 1
      price_list = order.client.price_lists.find_by(is_cito: 1)
      if price_list.present?
        price_list_item = price_list.price_list_items.find_by(exam_id: exam.id)
        if price_list_item.present?
          v_price = price_list_item.price
        end
      end
      if v_price == 0
        price_list = order.client.price_lists.find_by(is_cito: 0)
        if price_list.present?
          price_list_item = price_list.price_list_items.find_by(exam_id: exam.id, is_cito: 1)
          if price_list_item.present?
            v_price = price_list_item.price
          end
        end
      end
    end
    if v_price == 0
      price_list = order.client.price_lists.find_by(is_cito: 0)
      if price_list.present?
        price_list_item = price_list.price_list_items.find_by(exam_id: exam.id, is_cito: 0)
        if price_list_item.present?
          v_price = price_list_item.price
        end
      end
    end
    if v_price == 0
      if order.is_cito == 1 or is_cito == 1
        price_list = PriceList.find_by(is_general: 1, is_cito: 1)
        if price_list.present?
          price_list_item = price_list.price_list_items.find_by(exam_id: exam.id)
          if price_list_item.present?
            v_price = price_list_item.price
          end
        end
        if v_price == 0
          price_list = PriceList.find_by(is_general: 1, is_cito: 0)
          if price_list.present?
            price_list_item = price_list.price_list_items.find_by(exam_id: exam.id, is_cito: 1)
            if price_list_item.present?
              v_price = price_list_item.price
            end
          end
        end
      end
      if v_price == 0
        price_list = PriceList.find_by(is_general: 1, is_cito: 0)
        if price_list.present?
          price_list_item = price_list.price_list_items.find_by(exam_id: exam.id, is_cito: 0)
          if price_list_item.present?
            v_price = price_list_item.price
          end
        end
      end

    end
    v_price
  end

end
