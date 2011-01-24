require 'spec_helper'

describe "syms/new.html.erb" do
  before(:each) do
    assign(:sym, stub_model(Sym,
      :name => "MyString",
      :description => "MyString"
    ).as_new_record)
  end

  it "renders new sym form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => syms_path, :method => "post" do
      assert_select "input#sym_name", :name => "sym[name]"
      assert_select "input#sym_description", :name => "sym[description]"
    end
  end
end
