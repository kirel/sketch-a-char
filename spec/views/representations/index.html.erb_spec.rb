require 'spec_helper'

describe "representations/index.html.erb" do
  before(:each) do
    assign(:representations, [
      stub_model(Representation,
        :package => "Package",
        :command => "Command",
        :codepoint => "Codepoint",
        :sym => nil
      ),
      stub_model(Representation,
        :package => "Package",
        :command => "Command",
        :codepoint => "Codepoint",
        :sym => nil
      )
    ])
  end

  it "renders a list of representations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Package".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Command".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Codepoint".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
