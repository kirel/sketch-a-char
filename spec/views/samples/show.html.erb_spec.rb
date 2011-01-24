require 'spec_helper'

describe "samples/show.html.erb" do
  before(:each) do
    @sample = assign(:sample, stub_model(Sample,
      :data => "",
      :sym => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
