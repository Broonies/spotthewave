class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include Pundit::Authorization

  # after_action :verify_authorized, except: :index, unless: :skip_pundit?
  # after_action :verify_policy_scoped, only: :home, unless: :skip_pundit?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  def user_not_authorized
    redirect_to(root_path)
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^pages$)/
  end
end
