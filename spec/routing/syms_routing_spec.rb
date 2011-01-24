require "spec_helper"

describe SymsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/syms" }.should route_to(:controller => "syms", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/syms/new" }.should route_to(:controller => "syms", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/syms/1" }.should route_to(:controller => "syms", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/syms/1/edit" }.should route_to(:controller => "syms", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/syms" }.should route_to(:controller => "syms", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/syms/1" }.should route_to(:controller => "syms", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/syms/1" }.should route_to(:controller => "syms", :action => "destroy", :id => "1")
    end

  end
end
