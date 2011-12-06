# encoding: utf-8
require 'spec_helper'

describe UnicodeRepresentation do
  it { UnicodeRepresentation.new(unicode:'ϱ').codepoint.should == 1009 }
  it { UnicodeRepresentation.new(unicode:'ϱ').hex_codepoint.should == 'U+03F1' }
  it { UnicodeRepresentation.new(codepoint:'U+03f1').unicode.should == 'ϱ' }
end
