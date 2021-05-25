class Api::V1::SearchController < ApplicationController

  def contact_role_search
  a = Contact.find_by_role(params[:role])
  incident_check = Incident.where(id: params[:incident_id])

   if incident_check.empty?
     render json: {error: "No incident exists with that id"}, status: :not_found
   elsif a.empty?
     render json: {error: "No available contact with that role"}, status: :not_found
   elsif
     incident = incident_check.first
     available_contacts = []
     a.uniq.each_with_index do |contact, index|
      if contact.assigned_to_active_incident? == false
        attributes = {
          id: contact.id,
          name: contact.name,
          title: IncidentContact.contact_title(contact.id, params[:incident_id]),
          email: contact.email,
          phone_number: contact.phone_number,
          contact_location: "#{contact.city}, #{contact.state}",
          incident_location: "#{incident.city}, #{incident.state}"
        }
        available_contacts << IncidentContactInfo.new(attributes)
      end
     end
     available_contacts
     render json: IncidentContactsSerializer.new(available_contacts)
   end
  end
end
