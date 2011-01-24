require 'spec_helper'

describe "samples/new.html.erb" do
  before(:each) do
    assign(:sample, stub_model(Sample,
      :data => "",
      :sym => nil
    ).as_new_record)
  end

  it "renders new sample form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => samples_path, :method => "post" do
      assert_select "input#sample_data", :name => "sample[data]"
      assert_select "input#sample_sym", :name => "sample[sym]"
    end
  end
end
