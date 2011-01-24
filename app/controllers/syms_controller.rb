class SymsController < ApplicationController
  # GET /syms
  # GET /syms.xml
  def index
    @syms = Sym.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @syms }
    end
  end

  # GET /syms/1
  # GET /syms/1.xml
  def show
    @sym = Sym.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sym }
    end
  end

  # GET /syms/new
  # GET /syms/new.xml
  def new
    @sym = Sym.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sym }
    end
  end

  # GET /syms/1/edit
  def edit
    @sym = Sym.find(params[:id])
  end

  # POST /syms
  # POST /syms.xml
  def create
    @sym = Sym.new(params[:sym])

    respond_to do |format|
      if @sym.save
        format.html { redirect_to(@sym, :notice => 'Sym was successfully created.') }
        format.xml  { render :xml => @sym, :status => :created, :location => @sym }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sym.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /syms/1
  # PUT /syms/1.xml
  def update
    @sym = Sym.find(params[:id])

    respond_to do |format|
      if @sym.update_attributes(params[:sym])
        format.html { redirect_to(@sym, :notice => 'Sym was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sym.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /syms/1
  # DELETE /syms/1.xml
  def destroy
    @sym = Sym.find(params[:id])
    @sym.destroy

    respond_to do |format|
      format.html { redirect_to(syms_url) }
      format.xml  { head :ok }
    end
  end
end
