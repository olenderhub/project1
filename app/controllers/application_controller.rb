class ApplicationController < ActionController::Base
  rescue_from ActionController::RoutingError, :with => :render_not_found
  rescue_from StandardError, :with => :render_server_error
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |ex|
  	flash[:warning] = ex.message
  	redirect_to root_url
  end

  protected
    def render_not_found
      render "shared/404", :status => 404
    end

    def render_server_error
      render "shared/500", :status => 500
    end
end
