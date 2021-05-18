class Api::V1::IncidentsController < ApplicationController

  def index
    incidents = Incident.active(params[:active])
    render json: IncidentsSerializer.new(incidents)
  end

end
