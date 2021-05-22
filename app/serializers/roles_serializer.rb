class RolesSerializer
  include FastJsonapi::ObjectSerializer
  set_type "role"
  attributes  :title
end
