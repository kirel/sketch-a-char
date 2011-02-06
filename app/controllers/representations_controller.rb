class RepresentationsController < ApplicationController
  
  before_filter :find_sym

  def index
    @representations = Representation.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @representation = Representation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def new
    @latex_representation = LatexRepresentation.new
    @unicode_representation = UnicodeRepresentation.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
    @representation = Representation.find(params[:id])
    instance_variable_set "@#{@representation.class.model_name.underscore}", @representation
  end

  def create
    @latex_representation = LatexRepresentation.new(params[:latex_representation])
    @unicode_representation = UnicodeRepresentation.new(params[:unicode_representation])
    
    @representation = @latex_representation if params[:latex_representation]
    @representation = @unicode_representation if params[:unicode_representation]

    respond_to do |format|
      if @representation.save
        format.html { redirect_to([@sym, @representation], :notice => 'Representation was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @representation = Representation.find(params[:id])

    respond_to do |format|
      if @representation.update_attributes(representation_params)
        format.html { redirect_to([@sym, @representation], :notice => 'Representation was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @representation = Representation.find(params[:id])
    @representation.destroy

    respond_to do |format|
      format.html { redirect_to(sym_representations_url(@sym)) }
    end
  end
  
  protected
  
  def representation_params
    params[:latex_representation] || params[:unicode_representation]
  end
  
  def find_sym
    @sym = Sym.find(params[:sym_id])
  end  
end
