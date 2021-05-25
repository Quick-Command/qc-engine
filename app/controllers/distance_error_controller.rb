class DistanceErrorController < ApplicationController
  rescue_from TypeError, with: :type_error

  def error(message = "Invalid request error. Please check the request.")
    render json: { error: message }, status: :bad_request
  end

  def type_error(exception)
    render json: { error: 'Locations does not exist. Please enter valid locations.' }, status: :bad_request
  end

end
