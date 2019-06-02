# frozen_string_literal:true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login

  public
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  rescue
    render_404
  end

  def render_404
    render file: "#{Rails.root}/public/404", status: :not_found
  end

  private
  def logged_in?
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to login_path # прерывает цикл запроса
    end
  end

  helper_method :logged_in?
end