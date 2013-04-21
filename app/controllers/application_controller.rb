class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter do
    add_crumb t("navigation.home"), root_path
  end
  
  protected
  
  def require_user
    unless current_user
      session[:user_return_to] = request.url
      redirect_to new_session_path(User), alert: I18n.t("must_be_logged_into_access_this_page")
    end
  end
end
