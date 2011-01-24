require 'spec_helper'

describe "samples/index.html.erb" do
  before(:each) do
    assign(:samples, [
      stub_model(Sample,
        :data => "",
        :sym => nil
      ),
      stub_model(Sample,
        :data => "",
        :sym => nil
      )
    ])
  end

  it "renders a list of samples" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
