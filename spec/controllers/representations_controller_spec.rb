require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by the Rails when you ran the scaffold generator.

describe RepresentationsController do

  def mock_representation(stubs={})
    @mock_representation ||= mock_model(Representation, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all representations as @representations" do
      Representation.stub(:all) { [mock_representation] }
      get :index
      assigns(:representations).should eq([mock_representation])
    end
  end

  describe "GET show" do
    it "assigns the requested representation as @representation" do
      Representation.stub(:find).with("37") { mock_representation }
      get :show, :id => "37"
      assigns(:representation).should be(mock_representation)
    end
  end

  describe "GET new" do
    it "assigns a new representation as @representation" do
      Representation.stub(:new) { mock_representation }
      get :new
      assigns(:representation).should be(mock_representation)
    end
  end

  describe "GET edit" do
    it "assigns the requested representation as @representation" do
      Representation.stub(:find).with("37") { mock_representation }
      get :edit, :id => "37"
      assigns(:representation).should be(mock_representation)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created representation as @representation" do
        Representation.stub(:new).with({'these' => 'params'}) { mock_representation(:save => true) }
        post :create, :representation => {'these' => 'params'}
        assigns(:representation).should be(mock_representation)
      end

      it "redirects to the created representation" do
        Representation.stub(:new) { mock_representation(:save => true) }
        post :create, :representation => {}
        response.should redirect_to(representation_url(mock_representation))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved representation as @representation" do
        Representation.stub(:new).with({'these' => 'params'}) { mock_representation(:save => false) }
        post :create, :representation => {'these' => 'params'}
        assigns(:representation).should be(mock_representation)
      end

      it "re-renders the 'new' template" do
        Representation.stub(:new) { mock_representation(:save => false) }
        post :create, :representation => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested representation" do
        Representation.stub(:find).with("37") { mock_representation }
        mock_representation.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :representation => {'these' => 'params'}
      end

      it "assigns the requested representation as @representation" do
        Representation.stub(:find) { mock_representation(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:representation).should be(mock_representation)
      end

      it "redirects to the representation" do
        Representation.stub(:find) { mock_representation(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(representation_url(mock_representation))
      end
    end

    describe "with invalid params" do
      it "assigns the representation as @representation" do
        Representation.stub(:find) { mock_representation(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:representation).should be(mock_representation)
      end

      it "re-renders the 'edit' template" do
        Representation.stub(:find) { mock_representation(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested representation" do
      Representation.stub(:find).with("37") { mock_representation }
      mock_representation.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the representations list" do
      Representation.stub(:find) { mock_representation }
      delete :destroy, :id => "1"
      response.should redirect_to(representations_url)
    end
  end

end