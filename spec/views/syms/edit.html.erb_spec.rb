require 'spec_helper'

describe "syms/edit.html.erb" do
  before(:each) do
    @sym = assign(:sym, stub_model(Sym,
      :name => "MyString",
      :description => "MyString"
    ))
  end

  it "renders the edit sym form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => sym_path(@sym), :method => "post" do
      assert_select "input#sym_name", :name => "sym[name]"
      assert_select "input#sym_description", :name => "sym[description]"
    end
  end
end
