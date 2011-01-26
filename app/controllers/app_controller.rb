class AppController < ApplicationController
  before_filter :cache!
  respond_to :html, :json
  layout 'app'
  def index
    @app_data = AppData
    respond_with @app_data
  end
end
