# -*- encoding : utf-8 -*-
require 'date'

class Date

  # Present this date in ORIS compatible format.
  def oris_format
    self.strftime('%-d.%m.%Y')
  end

end
