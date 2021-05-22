class IncidentsSerializer
  include FastJsonapi::ObjectSerializer
  set_type "incident"
  attributes  :name,
              :active,
              :incident_type,
              :description,
              :start_date,
              :close_date,
              :location,
              :city,
              :state
end
