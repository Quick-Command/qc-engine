class Api::V1::ContactsController < ApplicationController
  def show
    contact = Contact.find(params[:id])
    render json: ContactSerializer.new(contact)
  end

  def create
    contact = Contact.new(contact_params)
    if params[:roles] == nil
      render json: {error: "At least one roll must be selected"}
    end

    if contact.save
      params[:roles].each do |role|
        role = (Role.where(title: role)).first
        ContactRole.create(contact_id: contact.id, role_id: role.id)
      end
      render json:ContactSerializer.new(contact)
    else
      binding.pry
    end
  end

  private

  def contact_params
    params.permit(:name, :email, :phone_number, :job_title, :city, :state, :roles)
  end
end
