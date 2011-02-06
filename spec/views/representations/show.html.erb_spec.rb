require 'spec_helper'

describe "representations/show.html.erb" do
  before(:each) do
    @representation = assign(:representation, stub_model(Representation,
      :package => "Package",
      :command => "Command",
      :codepoint => "Codepoint",
      :sym => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Package/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Command/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Codepoint/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
