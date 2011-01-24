class SamplesController < ApplicationController
  before_filter :find_sym
  before_filter :require_current_user, :except => [:index]
  
  def index
    @samples = @sym.samples.order('samples.plusminus_cache DESC').all
  end

  # ajax action
  def create
    @sample = @sym.samples.build(params[:sample])
    @sample.submitter = current_user

    if @sample.save
      head :created
    else
      render :json => @sample.errors, :status => :unprocessable_entity
    end
  end

  # ajax or normal
  def destroy
    @sample = @sym.samples.find(params[:id])
    @sample.destroy

    respond_to do |format|
      format.html { redirect_to(sym_samples_url(@sym)) }
      format.js  { head :ok }
    end
  end
  
  # ajax actions
  def vote_up
    @sample = @sym.samples.find(params[:id])
    current_user.vote_exclusively_for(@sample)
    head :ok
  end
  
  def vote_down
    @sample = @sym.samples.find(params[:id])
    current_user.vote_exclusively_against(@sample)
    head :ok
  end
  
  protected
  
  def find_sym
    @sym = Sym.find(params[:sym_id])
  end
end
