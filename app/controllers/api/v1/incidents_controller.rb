class Api::V1::IncidentsController < ApplicationController

  def index
    incidents = Incident.active(params[:active])
    render json: IncidentsSerializer.new(incidents)
  end

  def create
    incident = Incident.new(incident_params)
    if incident.save!
      render json: IncidentsSerializer.new(incident), status: :created
    else
      render json: IncidentCreateErrorSerializer.new
    end
  end

  private

  def incident_params
    params.permit(:name, :active, :incident_type, :description, :location, :start_date, :close_date )
  end
end
