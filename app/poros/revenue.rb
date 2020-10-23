class Revenue
  attr_reader :id, :revenue

  def initialize(revenue)
    @id = nil
    @revenue = revenue
  end

  def self.total_revenue(start_date, end_date)
    total = Invoice.joins(:transactions, :invoice_items)
      .where("invoices.status='shipped' AND transactions.result='success'")
      .where(:created_at => start(start_date)..final(end_date))
      .sum('invoice_items.unit_price * invoice_items.quantity')
    Revenue.new(total)
  end

  private

  def self.start(start_date)
    start_date.to_date.beginning_of_day
  end

  def self.final(end_date)
    end_date.to_date.end_of_day
  end
end
