require 'spec_helper'

require 'matrix'

describe Sample do
  before(:each) do
    User.destroy_all
    Sym.destroy_all
    @user = Factory :user
    @sym = Factory :sym
  end
  
  it "should serialize Arrays of Strokes and retrieve them later" do
    strokes = [[Vector[1,2]]]
    Sample.create!(:data => strokes) do |s|
      s.submitter = @user
      s.sym = @sym
    end
    Sample.first.data.should == strokes
  end
  
end
