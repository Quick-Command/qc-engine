class Api::V1::SearchController < ApplicationController

  def contact_role_search
  unavailable_contacts = Contact.contacts_assigned_to_active_incidents
  a = Contact.find_by_role(params[:role])

   if a.empty?
     render json: {error: "No available contact with that role"}
   else
     available_contacts = []
     a.each_with_index do |contact_by_role, index|
      if contact_by_role.assigned_to_active_incident? == false
        available_contacts << contact_by_role
      end
     end
     render json: IncidentContactSerializer.new(available_contacts)
   end
  end
end
