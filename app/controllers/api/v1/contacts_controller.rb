class Api::V1::ContactsController < ApplicationController
  def show
    contact = Contact.find(params[:id])
    render json: ContactSerializer.new(contact)
  end
end
