class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authorize
    not_authenticated! unless current_user
  end

private
  def not_authenticated!
    session[:return_to_url] = request.fullpath if request.get?
    respond_to do |format|
      # TODO [YAGNI]: do we need json?
      format.json do
        payload = {
          redirect_to: login_path,
          not_authorized: true,
          message: I18n.t('login_required')
        }
        response.status = 401
        render json: payload
      end
      format.html { redirect_to login_path, notice: I18n.t('sign_in_required') }
      # TODO [YAGNI]: do we need js?
      format.js { render js: "window.location.href = #{login_path}", status: 303 }
    end
  end
end
