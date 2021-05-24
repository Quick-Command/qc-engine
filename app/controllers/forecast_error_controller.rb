class ForecastErrorController < ApplicationController

  rescue_from JSON::ParserError, with: :render_unavailable
  rescue_from TypeError, with: :type_error

  def error(message = "Invalid request error. Please check the request.")
    render json: { error: message }, status: :bad_request
  end

  def type_error(exception)
    render json: { error: 'Please enter a valid location with city and state.' }, status: :bad_request
  end

  def render_unavailable(exception)
    render json: { error: 'Location does not exist. Please enter valid location.' }, status: :bad_request
  end
end
