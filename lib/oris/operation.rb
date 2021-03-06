# -*- encoding : utf-8 -*-
require 'c12-commons'
require 'csv'

module ORIS

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
    # Name of the debit account.
    attr_accessor :name_debit
    # Credit (-) account number.
    attr_accessor :acc_credit
    # Name of the credit account.
    attr_accessor :name_credit

    # Amount and currency of the document.
    attr_accessor :amount, :currency, :type
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

    # Errors.
    def errors
      @errors
    end

    # Validate this operation.
    def validate
      @errors = []
      @errors.push('დებიტორული ანგარიში არაა განსაზღვრული') if self.acc_debit.blank?
      @errors.push('კრედიტორული ანგარიში არაა განსაზღვრული') if self.acc_credit.blank?
    end

    def valid?
      self.errors.nil? or self.errors.size == 0
    end

    def initialize(opts = {})
      opts.each do |k, v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end

    def calc_amount
      unless self.amount.nil?
        case self.type
        when VAT_PRICE then (self.amount - (self.amount/1.18).round(2)).round(2)
        when EXCLUDE_VAT_PRICE then (self.amount/1.18).round(2)
        else self.amount.round(2)
        end
      end
    end

    # Operation representation as an arrya (row).
    def to_a
      docnumb  = self.number
      docdate  = self.date ? self.date.oris_format : Date.today.oris_format
      currency = self.currency ? self.currency : 'GEL'
      project   = self.project ? self.project.to_geo : ' მთ.წიგნი'.to_geo
      sysdate  = self.sysdate ? self.sysdate.oris_format : Date.today.oris_format
      unit = self.unit ? self.unit.to_geo : 'ერთეული'.to_geo
      quant = self.quantity || 0
      quant2 = self.quantity_normal || quant
      user = self.user ? self.user.to_geo : ''
      ['', '', '', docnumb, '0', docdate, ORIS.oris_acc_code(self.acc_debit), ORIS.oris_acc_code(self.acc_credit),
        '0', self.calc_amount, currency, self.description, '0', '1', unit, quant, quant2, project, user,
        '0', '9', '0', '', '0', sysdate, self.related_to, '0', '1', '3', '', '0', '', '']
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

end
