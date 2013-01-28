# -*- encoding : utf-8 -*-
require 'spec_helper'

describe 'date formatting in oris' do
  specify { Date.new(2012,5,1).oris_format().should == '1.05.2012' }
  specify { Date.new(2012,12,23).oris_format().should == '23.12.2012' }
end
