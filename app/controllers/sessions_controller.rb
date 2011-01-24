class SessionsController < ApplicationController
  skip_before_filter :authenticate
  def create
    render :text => request.env['rack.auth'].inspect
  end
end