class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  def require_admin
    redirect_to root_path, alert: "Not authorized!" unless current_user.admin?
  end

  def require_instructor
    redirect_to root_path, alert: "Not authorized!" unless current_user.instructor? || current_user.admin?
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :role])
  end
end
