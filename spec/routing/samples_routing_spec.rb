require "spec_helper"

describe SamplesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/samples" }.should route_to(:controller => "samples", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/samples/new" }.should route_to(:controller => "samples", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/samples/1" }.should route_to(:controller => "samples", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/samples/1/edit" }.should route_to(:controller => "samples", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/samples" }.should route_to(:controller => "samples", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/samples/1" }.should route_to(:controller => "samples", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/samples/1" }.should route_to(:controller => "samples", :action => "destroy", :id => "1")
    end

  end
end
