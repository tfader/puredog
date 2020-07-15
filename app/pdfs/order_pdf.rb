require 'prawn'
class OrderPdf < Prawn::Document
  def initialize(order)
    super(top_margin: 70)
    @order = order
    t = make_table([ ["this is the first row"],
                     ["this is the second row"] ])
    t.draw
    move_down 20
    order_items_table = [['Pacjent', 'Badanie', 'Wynik', 'Cena']]
    order.order_items.each do |order_item|
      if order_item.last_result.present?
        last_result_result = order_item.last_result.result
      else
        last_result_result = 'N/A'
      end
      order_items_table.push([order_item.patient.name_with_patron_name, order_item.exam.name, last_result_result, order_item.item_price.to_s])
    end
    table(order_items_table, :column_widths => [200, 200, 50, 50], :header => true)
    svg '<svg><rect width="100" height="100" fill="red"></rect></svg>'
  end

end