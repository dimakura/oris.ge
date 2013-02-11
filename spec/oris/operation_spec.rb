# -*- encoding : utf-8 -*-

describe 'operation to csv' do
  before(:all) do
    @operation = ORIS::Operation.new(number: '001', acc_debit: '7210-01', acc_credit: '1610-01', amount: 10, quantity: 100, user: 'დიმიტრი ყურაშვილი')
  end
  subject { @operation.to_a }
  its(:size) { should == 33 }
  specify { subject[0].should == '' }
  specify { subject[1].should == '' }
  specify { subject[2].should == '' }
  specify { subject[3].should == '001' }
  specify { subject[4].should == '0' }
  specify { subject[5].should == Date.today.oris_format }
  specify { subject[6].should == '7 2 10 01' }
  specify { subject[7].should == '1 6 10 01' }
  specify { subject[8].should == '0' }
  specify { subject[9].should == 10 }
  specify { subject[10].should == 'GEL' }
  specify { subject[11].should be_nil }
  specify { subject[12].should == '0' }
  specify { subject[13].should == '1' }
  specify { subject[14].should == 'ერთეული'.to_geo }
  specify { subject[15].should == 100 }
  specify { subject[16].should == 100 }
  specify { subject[17].should == ' მთ.წიგნი'.to_geo }
  specify { subject[18].should == 'დიმიტრი ყურაშვილი'.to_geo }
  specify { subject[19].should == '0' }
  specify { subject[20].should == '9' }
  specify { subject[21].should == '0' }
  specify { subject[22].should == '' }
  specify { subject[23].should == '0' }
  specify { subject[24].should == Date.today.oris_format }
  specify { subject[25].should be_nil }
  specify { subject[26].should == '0' }
  specify { subject[27].should == '1' }
  specify { subject[28].should == '3' }
  specify { subject[29].should == '' }
  specify { subject[30].should == '0' }
  specify { subject[31].should == '' }
  specify { subject[32].should == '' }
end

describe 'VAT calculations' do
  context do
    subject { ORIS::Operation.new(amount: 10) }
    its(:calc_amount) { should == 10 }
  end
  context do
    subject { ORIS::Operation.new(amount: 10, type: ORIS::VAT_PRICE) }
    its(:calc_amount) { should == 1.53 }
  end
  context do
    subject { ORIS::Operation.new(amount: 10, type: ORIS::EXCLUDE_VAT_PRICE) }
    its(:calc_amount) { should == 8.47 }
  end
  context do
    subject { ORIS::Operation.new(amount: 10.34, type: ORIS::EXCLUDE_VAT_PRICE) }
    its(:calc_amount) { should == 8.76 }
  end
end
