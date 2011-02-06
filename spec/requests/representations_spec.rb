require 'spec_helper'

describe "Representations" do
  describe "GET /representations" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get representations_path
      response.status.should be(200)
    end
  end
end
