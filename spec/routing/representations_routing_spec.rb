require "spec_helper"

describe RepresentationsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/representations" }.should route_to(:controller => "representations", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/representations/new" }.should route_to(:controller => "representations", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/representations/1" }.should route_to(:controller => "representations", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/representations/1/edit" }.should route_to(:controller => "representations", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/representations" }.should route_to(:controller => "representations", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/representations/1" }.should route_to(:controller => "representations", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/representations/1" }.should route_to(:controller => "representations", :action => "destroy", :id => "1")
    end

  end
end
