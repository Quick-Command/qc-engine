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

  def show
    incident = Incident.where(id: params[:id])
    if incident.count == 0
      error = "Incident does not exist with that id"
      render json: { error: error }, status: :not_found
    else
      render json: IncidentsSerializer.new(incident.first)
    end
  end

  private

  def incident_params
    params.permit(:name, :active, :incident_type, :description, :location, :start_date, :close_date )
  end

  def validate_inicdent_params
    if params[:name].nil? || params[:name] == ""
      error = "Incident name cannot be blank."
      render json: { error: error }, status: :not_found
    elsif params[:incident_type].nil? || params[:incident_type] == ""
      error = "Incident type cannot be blank."
      render json: { error: error }, status: :not_found
    elsif params[:location].nil? || params[:location] == ""
      error = "Incident location cannot be blank."
      render json: { error: error }, status: :not_found
    elsif params[:start_date].nil? || params[:start_date] == ""
      error = "Incident start date cannot be blank."
      render json: { error: error }, status: :not_found
    elsif params[:close_date].nil? || params[:close_date] == ""
      error = "An inactive incident needs a close date"
      render json: { error: error }, status: :not_found
    end
  end
end
