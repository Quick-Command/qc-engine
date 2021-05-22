class ContactSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :email, :phone_number, :job_title, :city, :state

  attribute :roles do |object|
   RolesSerializer.new(object.roles)
  end
end
