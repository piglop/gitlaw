class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter do
    add_crumb t("navigation.home"), root_path
  end
end
