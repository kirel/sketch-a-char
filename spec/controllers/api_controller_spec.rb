require 'spec_helper'

describe ApiController do

  describe "GET 'samples'" do
    it "should be successful" do
      get 'samples'
      response.should be_success
    end
  end

  describe "GET 'symbols'" do
    it "should be successful" do
      get 'symbols'
      response.should be_success
    end
  end

end
