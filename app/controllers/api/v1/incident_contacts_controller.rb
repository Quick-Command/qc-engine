class Api::V1::IncidentContactsController < ApplicationController

  def assign_contact_to_incident
    incident = Incident.where(id: incident_contact_params[:incident_id])
    contact = Contact.where(id: incident_contact_params[:contact_id])
    incident_contact = IncidentContact.new(incident_contact_params)

    if incident.empty?
      render json: {error: "Incident does not exist"}, status: :not_found
    elsif contact.empty?
      render json: {error: "Contact does not exist"}, status: :not_found
    elsif contact[0].assigned_to_active_incident? == true
      render json: {error: "Contact is assigned to another incident"}, status: 400
    elsif incident_contact.save
      render json: IncidentContactSerializer.new(contact.first, {params: {distance_miles: distance_miles, distance_minutes: distance_minutes, title: incident_contact_params[:title]}})
    elsif incident_contact_params[:title] == nil || incident_contact_params[:title] == ""
      render json: {error: "Title must be assigned"}, status: 400
    end
  end

  def show
    incident_contact_check = IncidentContact.where(contact_id: incident_contact_params[:contact_id])
    if incident_contact_check.empty?
      render json: {error: "Contact is not assigned to incident"}, status: :not_found
    else
      contact = Contact.find(incident_contact_params[:contact_id])
      incident = Incident.find(incident_contact_params[:incident_id])
      incident_contact = incident_contact_check.first
      attributes = {
        id: contact.id,
        name: contact.name,
        title: IncidentContact.contact_title(contact.id, incident.id),
        email: contact.email,
        phone_number: contact.phone_number,
        contact_location: "#{contact.city}, #{contact.state}",
        incident_location: "#{incident.city}, #{incident.state}"
      }
      new_contact_info = IncidentContactInfo.new(attributes)
      render json: IncidentContactsSerializer.new(new_contact_info)
    end
  end

  def all_contacts_assigned_to_incident
    incident_contacts = Contact.joins(:incidents).where("incidents.id = ?", params[:incident_id])
    incident_check = Incident.where(id: params[:incident_id])
    if incident_contacts.empty?
      render json: { error: "No contacts are assigned to this incident" }, status: :not_found
    elsif incident_check.empty?
      render json: { error: "The incident does not exist for the given ID" }, status: :not_found
    elsif
      incident = incident_check.first
      new_incident_contacts =incident_contacts.map do |contact|
        attributes = {
          id: contact.id,
          name: contact.name,
          title: IncidentContact.contact_title(contact.id, incident.id),
          email: contact.email,
          phone_number: contact.phone_number,
          contact_location: "#{contact.city}, #{contact.state}",
          incident_location: "#{incident.city}, #{incident.state}"
        }
        IncidentContactInfo.new(attributes)
      end
      render json: IncidentContactsSerializer.new(new_incident_contacts)
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
