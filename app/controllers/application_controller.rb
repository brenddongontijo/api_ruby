class ApplicationController < ActionController::API
  def index
    render html: 'Test'
  end
end
