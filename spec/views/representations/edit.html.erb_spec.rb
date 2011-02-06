require 'spec_helper'

describe "representations/edit.html.erb" do
  before(:each) do
    @representation = assign(:representation, stub_model(Representation,
      :package => "MyString",
      :command => "MyString",
      :codepoint => "MyString",
      :sym => nil
    ))
  end

  it "renders the edit representation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => representation_path(@representation), :method => "post" do
      assert_select "input#representation_package", :name => "representation[package]"
      assert_select "input#representation_command", :name => "representation[command]"
      assert_select "input#representation_codepoint", :name => "representation[codepoint]"
      assert_select "input#representation_sym", :name => "representation[sym]"
    end
  end
end
