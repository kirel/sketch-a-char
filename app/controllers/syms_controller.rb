class SymsController < ApplicationController
  load_and_authorize_resource

  def index
    @syms = Sym.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @syms } # TODO part of the public api
    end
  end

  def show
    @sym = Sym.find(params[:id])
  end

  def new
    @sym = Sym.new
  end

  def edit
    @sym = Sym.find(params[:id])
  end

  def create
    @sym = Sym.new(params[:sym])

    if @sym.save
      redirect_to(@sym, :notice => 'Symbol was successfully created. Please add representions and training data!')
    else
      render :action => "new"
    end
  end

  def update
    @sym = Sym.find(params[:id])

    if @sym.update_attributes(params[:sym])
      redirect_to([:edit, @sym], :notice => 'Symbol was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @sym = Sym.find(params[:id])
    @sym.destroy

    redirect_to(syms_url, :notice => 'Symbol removed.')
  end
end
