class ContactSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :email, :phone_number
end
