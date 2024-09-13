class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  rescue_from AppErrors::NotAuthorizedError do |e|
    respond_to do |format|
      format.html { render_error_page(401) }
      format.json { render_json_error(e.message, 401) }
    end
  end

  rescue_from ActiveRecord::RecordNotFound, ActionController::UnknownFormat do |e|
    respond_to do |format|
      format.html { render_error_page(404) }
      format.json { render_json_error(e.message, 404) }
    end
  end

  def authenticate_request
    return true if current_user

    raise AppErrors::NotAuthorizedError, "Not authenticated"
  end

  def current_user
    @current_user ||= user_id && User.find_by(id: user_id)
  end

  def user_id
    session[:user_id]
  end

  private

  def render_json_error(msg, status)
    render json: { status: "error", message: msg }, status:
  end

  def render_error_page(code)
    render file: Rails.root.join("public/#{code}.html").to_s, layout: false, status: code
  end
end
