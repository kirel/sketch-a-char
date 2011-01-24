class SamplesController < ApplicationController
  before_filter :find_sym
  before_filter :require_current_user, :only => [:new, :create, :edit, :update, :destroy]
  
  # possible for everyone
  def index
    @samples = @sym.samples.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @samples }
    end
  end

  # TODO don't really need that?!
  def show
    @sample = @sym.samples.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sample }
    end
  end

  # Not necessary
  def new
    @sample = @sym.samples.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sample }
    end
  end

  # GET /samples/1/edit
  def edit
    @sample = @sym.samples.find(params[:id])
  end

  # POST /samples
  # POST /samples.xml
  def create
    @sample = @sym.samples.build(params[:sample])
    @sample.submitter = current_user

    respond_to do |format|
      if @sample.save
        format.html { redirect_to([@sym, @sample], :notice => 'Sample was successfully created.') }
        format.xml  { render :xml => @sample, :status => :created, :location => @sample }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sample.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /samples/1
  # PUT /samples/1.xml
  def update
    @sample = @sym.samples.find(params[:id])

    respond_to do |format|
      if @sample.update_attributes(params[:sample])
        format.html { redirect_to([@sym, @sample], :notice => 'Sample was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sample.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /samples/1
  # DELETE /samples/1.xml
  def destroy
    @sample = @sym.samples.find(params[:id])
    @sample.destroy

    respond_to do |format|
      format.html { redirect_to(sym_samples_url(@sym)) }
      format.xml  { head :ok }
    end
  end
  
  protected
  
  def find_sym
    @sym = Sym.find(params[:sym_id])
  end
end
