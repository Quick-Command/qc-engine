class ApplicationController < ActionController::API
  rescue_from JSON::ParserError, with: :render_unavailable

  def error(message = "Invalid request error. Please check the r")
    render json: { error: message }, status: :bad_request
  end

  def render_unavailable(exception)
    render json: { error: 'Location does not exist. Please enter valid location.' }, status: :bad_request
  end
end
