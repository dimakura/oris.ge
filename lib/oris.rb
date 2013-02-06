# -*- encoding : utf-8 -*-
require 'oris/version'
require 'oris/date'
require 'oris/operation'

module ORIS

  # Ledger code for VAT transaction (in-mode).
  VAT_LEDGER_CODE_IN  = '3340'

  # Ledger code for VAT transaction (out-mode).
  VAT_LEDGER_CODE_OUT = '3330'

  # Format accounting code, according to ORIS conventions.
  def self.oris_acc_code(text)
    if text
      stripped = text.scan(/\d+/).join
      if (stripped.size > 4)
        [ stripped[0], stripped[1], stripped[2..3], stripped[4..-1] ].join(' ')
      end
    end
  end

end