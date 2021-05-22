class IncidentContactSerializer
  include FastJsonapi::ObjectSerializer
  set_type "incident_contact"
  attributes  :name

  attribute :title do |object, params|
    params[:title]
  end
  attributes    :email,
                :phone_number,
                :city,
                :state

  attribute :distance_miles do |object, params|
    params[:distance_miles]
  end

  attribute :distance_minutes do |object, params|
    params[:distance_minutes]
  end
end
