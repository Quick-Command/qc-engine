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
      render json: IncidentContactSerializer.new(incident_contact)
    else
      render json: {error: "Title must be assigned"}
    end
  end

  private

  def incident_contact_params
    params.permit(:title, :incident_id, :contact_id)
  end
end
