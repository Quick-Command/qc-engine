class Api::V1::IncidentContactsController < ApplicationController

  def assign_contact_to_incident
    incident = Incident.where(id: incident_contact_params[:incident_id])
    contact = Contact.where(id: incident_contact_params[:contact_id])
    incident_contact = IncidentContact.new(incident_contact_params)

    if incident.empty?
      render json: {error: "Incident does not exist"}, status: :not_found
    elsif contact.empty?
      render json: {error: "Contact does not exist"}, status: :not_found
    elsif incident_contact.save
      render json: IncidentContactSerializer.new(contact.first, {params: {distance_miles: distance_miles, distance_minutes: distance_minutes, title: incident_contact_params[:title]}})
    else
      render json: {error: "Title must be assigned"}
    end
  end

  private

  def incident_contact_params
    params.permit(:title, :incident_id, :contact_id)
  end

  def distance_miles
    incident_location = Incident.find(incident_contact_params[:incident_id])
    contact_location = Contact.find(incident_contact_params[:contact_id])
    "20"
  end

  def distance_minutes
    incident_location = Incident.find(incident_contact_params[:incident_id])
    contact_location = Contact.find(incident_contact_params[:contact_id])
    "40"
  end
end
