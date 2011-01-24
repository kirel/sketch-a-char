require 'spec_helper'

require 'matrix'

describe Sample do
  it "should serialize Arrays of Strokes and retrieve them later" do
    strokes = [[Vector[1,2]]]
    Sample.create! :data => strokes
    Sample.first.data.should == strokes
  end
end
