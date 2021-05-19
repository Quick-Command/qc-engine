class Api::V1::IncidentsController < ApplicationController

  def index
    incidents = Incident.active(params[:active])
    render json: IncidentsSerializer.new(incidents)
  end

  def create
    incident = Incident.new(incident_params)
    if incident.save
      render json: IncidentsSerializer.new(incident), status: :created
    else
      validate_inicdent_params
    end
  end

  private

  def incident_params
    params.permit(:name, :active, :incident_type, :description, :location, :start_date, :close_date )
  end

  def validate_inicdent_params
    if params[:name].nil? || params[:name] == ""
      error = "Name cannot be blank."
      render json: ErrorSerializer.new(error)
    elsif params[:incident_type].nil? || params[:incident_type] == ""
      error = "Incident type cannot be blank."
      render json: ErrorSerializer.new(error)
    elsif params[:location].nil? || params[:location] == ""
      error = "Location cannot be blank."
      render json: ErrorSerializer.new(error)
    elsif params[:start_date].nil? || params[:start_date] == ""
      error = "Start date cannot be blank."
      render json: ErrorSerializer.new(error)
    else
    end
  end
end
