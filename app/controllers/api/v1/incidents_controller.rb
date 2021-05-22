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

  def update
    incident = Incident.where(id: params[:id])
    if incident.count == 0
      error = "Incident does not exist with that id"
      render json: { error: error }, status: :not_found
    elsif validate_update_params?
        incident.update(incident_params)
        render json: IncidentsSerializer.new(incident.first)
    else
      update_validation_errors
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
    params.permit(:name, :active, :incident_type, :description, :location, :start_date, :close_date, :city, :state)
  end

  def validate_inicdent_params
    if params[:name].nil? || params[:name] == ""
      error = "Incident name cannot be blank."
      render json: { error: error }, status: :not_found
    elsif params[:incident_type].nil? || params[:incident_type] == ""
      error = "Incident type cannot be blank."
      render json: { error: error }, status: :not_found
    elsif params[:city].nil? || params[:city] == ""
      error = "Incident city cannot be blank."
      render json: { error: error }, status: :not_found
    elsif params[:state].nil? || params[:state] == ""
      error = "Incident state cannot be blank."
      render json: { error: error }, status: :not_found
    elsif params[:start_date].nil? || params[:start_date] == ""
      error = "Incident start date cannot be blank."
      render json: { error: error }, status: :not_found
    elsif incident_params[:active] == false
      if incident_params[:close_date].nil? || incident_params[:close_date] == ""
        error = "An inactive incident needs a close date"
        render json: { error: error }, status: :not_found
      end
    end
  end

  def validate_update_params?
    incident_params.each do |param|
      return false if param[-1] == ""
    end
  end

  def update_validation_errors
    incident = Incident.find(params[:id])
    if incident_params[:name] == ""
      error = "Incident name cannot be blank."
      render json: { error: error }, status: :not_found
    elsif incident_params[:incident_type] == ""
      error = "Incident type cannot be blank."
      render json: { error: error }, status: :not_found
    elsif incident_params[:location] == ""
      error = "Incident location cannot be blank."
      render json: { error: error }, status: :not_found
    elsif incident_params[:start_date] == ""
      error = "Incident start date cannot be blank."
      render json: { error: error }, status: :not_found
    elsif incident[:active] == false
      if incident_params[:close_date].nil? || incident_params[:close_date] == ""
        error = "An inactive incident needs a close date"
        render json: { error: error }, status: :not_found
      end
    end
  end
end
