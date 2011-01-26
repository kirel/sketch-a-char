class ApiController < ApplicationController
  respond_to :json
  before_filter :cache!
  
  def samples
    @samples = Sym.all.inject({}) { |h,sym| h[sym.id] = sym.samples.best_first.limit(5).map(&:data); h }
    respond_with @samples
  end

  def symbols
    @symbols = Sym.all
    respond_with @symbols, :except => [:cached_slug, :created_at, :updated_at]
  end
  
end
