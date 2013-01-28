# -*- encoding : utf-8 -*-

class Operation
  # Document number
  attr_accessor :number
  # Number of the document, this document is related to
  attr_accessor :related_to
  # Short description
  attr_accessor :description
  # Date of the document
  attr_accessor :date

  # Debit (+) account number.
  attr_accessor :acc_debit
  # Credit (-) account number.
  attr_accessor :acc_credit

  # Amount and currency of the document.
  attr_accessor :amount, :currency
  # Quantity in base units.
  attr_accessor :quantity
  # Normal quantity -- quantity in most small unit.
  attr_accessor :quantity_normal
  # Unit quantity.
  attr_accessor :unit

  # Project used.
  attr_accessor :project
  # User who performed this operation and operation's date.
  attr_accessor :user, :sysdate

  # Operation representation as an arrya (row).
  def to_a
    docnumb  = self.number
    docdate  = self.date ? self.date.oris_format : Date.today.oris_format
    currency = self.currency ? self.currency : 'GEL'
    project   = self.project ? self.project : ' მთ.წიგნი'.to_geo
    sysdate  = self.sysdate ? self.sysdate.oris_format : Date.today.oris_format
    unit = self.unit ? self.unit : 'ერთეული'
    quant = self.quantity || 0
    quant2 = self.quantity_normal || quant
    ['', '', '', docnumb, '0', docdate, self.acc_debit, self.acc_credit, '0', self.amount, currency,
      self.description, '0', '1', unit, quant, quant2, project, self.user, '0', '9', '0', '', '0',
      sysdate, self.related_to, '0', '1', '3', '', '0', '', '']
  end

  # Convert to CSV.
  def self.to_csv(opts)
    CSV.generate(force_quotes: true) do |csv|
      opts.each do |opt|
        csv << opt.to_a
      end
    end
  end

end
