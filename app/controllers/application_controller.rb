class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # ログインしていない場合は自動的にログインのパスに飛ばされる(新規登録ページには遷移できる)
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
