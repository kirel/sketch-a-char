class SamplesController < ApplicationController
  load_and_authorize_resource :sym
  load_and_authorize_resource through: :sym

  # ajax action
  def create
    @sample = @sym.samples.build(params[:sample])
    @sample.submitter = current_user

    if @sample.save
      flash[:success] = 'Saved.'
      # create.js
    else
      flash[:error] = @sample.errors.full_messages.to_sentence
      head :unprocessable_entity
    end
  end

  # ajax or normal
  def destroy
    @sample = @sym.samples.find(params[:id])
    @sample.destroy

    respond_to do |format|
      format.html { redirect_to(sym_samples_url(@sym)) }
      format.js # destry.js.erb
    end
  end

  # ajax actions
  def vote_up
    @sample = @sym.samples.find(params[:id])
    current_user.vote_exclusively_for(@sample)
  end

  def vote_down
    @sample = @sym.samples.find(params[:id])
    current_user.vote_exclusively_against(@sample)
  end

end
