class ApplicationController < ActionController::Base
  protect_from_forgery

  include Userstamp # gem userstamp

  before_filter :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  # Draper decorate current_user
  def current_user
    signed_in? ? super.decorate : super
  end

end
