class IncidentsSerializer
  include FastJsonapi::ObjectSerializer
  set_type "incident"
  attributes  :name,
              :active,
              :incident_type,
              :description,
              :location,
              :start_date,
              :close_date
end
