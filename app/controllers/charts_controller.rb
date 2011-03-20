class ChartsController < ApplicationController
  def index
    @top_samples = Sample.top.limit(10)
    @flop_samples = Sample.flop.limit(10)
    
    @top_users = User.top.limit(10)
  end
end
