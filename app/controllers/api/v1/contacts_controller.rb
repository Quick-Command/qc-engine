class Api::V1::ContactsController < ApplicationController
  def show
    contact = Contact.find(params[:id])
    render json: ContactSerializer.new(contact)
  end

  def create
    contact = Contact.new(contact_params)
    if params[:roles] == nil || params[:roles].empty?
      render json: {error: "At least one role must be selected"}, status: 400
    elsif contact.save
      params[:roles].each do |role|
        role = Role.find_or_create_by(title: role)
        ContactRole.create(contact_id: contact.id, role_id: role.id)
      end
      role = Role.find_or_create_by(title: contact_params[:job_title])
      ContactRole.create(contact_id: contact.id, role_id: role.id)
      
      render json:ContactSerializer.new(contact)
    else
      render json: {error: "Name, email, phone, city, or state cannot be blank"}, status: 400
    end
  end

  private

  def contact_params
    params.permit(:name, :email, :phone_number, :job_title, :city, :state, :roles)
  end
end
