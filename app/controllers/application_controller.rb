class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery with: :exception
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  include Pundit
  def after_sign_out_path_for(_resource)
    session[:current_role] = 'Viewer'
    root_path
  end

  def new_session_path(_scope)
    user_github_omniauth_authorize_path
 end

  def user_not_authorized
    flash[:warning] = 'You are not authorized to perform this action.'
    redirect_to(request.referrer || root_path)
  end

  helper_method :current_role
  def current_role
    # session[:current_role] = 'Viewer'
    session[:current_role]
  end

  def pundit_user
    UserContext.new(current_user, session)
  end
end
