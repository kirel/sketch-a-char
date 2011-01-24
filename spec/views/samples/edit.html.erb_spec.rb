require 'spec_helper'

describe "samples/edit.html.erb" do
  before(:each) do
    @sample = assign(:sample, stub_model(Sample,
      :data => "",
      :sym => nil
    ))
  end

  it "renders the edit sample form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => sample_path(@sample), :method => "post" do
      assert_select "input#sample_data", :name => "sample[data]"
      assert_select "input#sample_sym", :name => "sample[sym]"
    end
  end
end
