class IncidentContactsSerializer
  include FastJsonapi::ObjectSerializer
  set_type "incident_contact"
  attributes  :name,
              :title,
              :email,
              :phone_number,
              :city,
              :state,
              :distance_miles,
              :distance_minutes

end
