require 'spec_helper'

describe "representations/new.html.erb" do
  before(:each) do
    assign(:representation, stub_model(Representation,
      :package => "MyString",
      :command => "MyString",
      :codepoint => "MyString",
      :sym => nil
    ).as_new_record)
  end

  it "renders new representation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => representations_path, :method => "post" do
      assert_select "input#representation_package", :name => "representation[package]"
      assert_select "input#representation_command", :name => "representation[command]"
      assert_select "input#representation_codepoint", :name => "representation[codepoint]"
      assert_select "input#representation_sym", :name => "representation[sym]"
    end
  end
end
