class Api::V1::SearchController < ApplicationController

  def contact_role_search
   a = Contact.find_by_role(params[:role])

   if a.empty?
     render json: {error: "No available contact with that role"}
   else
     render json: IncidentContactSerializer.new(a)
   end

  end
end
