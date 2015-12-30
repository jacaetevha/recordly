class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token, if: :json_request?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authorize
    not_authenticated! unless current_user
  end

protected

  def json_request?
    request.format.json?
  end

  def render_bad_request(reason=nil)
    respond_to do |format|
      format.json do
        payload = {error: 'Bad request'}.tap do |hash|
          hash[:reason] = reason if reason.present?
        end
        render json: payload.to_json, status: :bad_request
      end
      format.html { redirect_to 'errors/bad_request', reason: reason }
    end and yield
  end

private

  def not_authenticated!
    case request.format
    when Mime::JSON
      if user = authenticate_with_http_basic { |u, p| User.find_by_email(u).authenticate(p) }
        @current_user = user
      else
        request_http_basic_authentication
      end
      return
    end

    session[:return_to_url] = request.fullpath if request.get?
    respond_to do |format|
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
    end
  end
end
