require 'rails_helper'

RSpec.describe "Create an incident" do
  describe "happy path" do
    it "creates an incident with active set to true as default" do
      incident_params = ({
        name: "Jim Creeks Fire",
        incident_type: "Fire",
        description: "5th alarm fire",
        city: "Denver",
        state: "CO",
        start_date: "2020-05-01",
        close_date: ""
         })

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/incidents", headers: headers, params: JSON.generate(incident_params)
      created_incident = Incident.last

      expect(response).to be_successful
      expect(created_incident.name).to eq(incident_params[:name])
      expect(created_incident.active).to eq(true)
      expect(created_incident.description).to eq(incident_params[:description])
      expect(created_incident.incident_type).to eq(incident_params[:incident_type])
      expect(created_incident.start_date).to eq(incident_params[:start_date])
      expect(created_incident.close_date).to eq(nil)

      expect(response).to have_http_status(:created)
      incident = JSON.parse(response.body, symbolize_names: true)
    end
    it "creates an incident with specified active status" do
      incident_params = ({
        name: "Jim Creeks Fire",
        incident_type: "Fire",
        active: false,
        description: "5th alarm fire",
        location: "Jim's Creek",
        city: "Denver",
        state: "CO",
        start_date: "2020-05-01",
        close_date: "2020-05-10"
         })

       headers = {"CONTENT_TYPE" => "application/json"}

       post "/api/v1/incidents", headers: headers, params: JSON.generate(incident_params)
       created_incident = Incident.last

       expect(response).to be_successful
       expect(created_incident.name).to eq(incident_params[:name])
       expect(created_incident.active).to eq(false)
       expect(created_incident.description).to eq(incident_params[:description])
       expect(created_incident.incident_type).to eq(incident_params[:incident_type])
       expect(created_incident.start_date).to eq(incident_params[:start_date])
       expect(created_incident.close_date).to eq("2020-05-10 00:00:00.000000000 +0000")

       expect(response).to have_http_status(:created)
       incident = JSON.parse(response.body, symbolize_names: true)
    end
   end

  describe "sad path" do
    it "Won't create a new incident with missing incident_type" do
      incident_params = ({
        name: "Jim Creeks Fire",
        incident_type: "",
        active: false,
        description: "5th alarm fire",
        location: "Jim's Creek",
        city: "Denver",
        state: "CO",
        start_date: "2020-05-01",
        close_date: "2020-05-10"
         })
     headers = {"CONTENT_TYPE" => "application/json"}

     post "/api/v1/incidents", headers: headers, params: JSON.generate(incident_params)

     error = JSON.parse(response.body, symbolize_names:true)
     error_message = "Incident type cannot be blank."

     expect(response).to have_http_status(:not_found)
     expect(error).to have_key(:error)
     expect(error[:error]).to eq("#{error_message}")
    end
    it "Won't create a new incident with missing name" do
      incident_params = ({
        name: "",
        incident_type: "Fire",
        active: false,
        description: "5th alarm fire",
        location: "Jim's Creek",
        city: "Denver",
        state: "CO",
        start_date: "2020-05-01",
        close_date: "2020-05-10"
         })
     headers = {"CONTENT_TYPE" => "application/json"}

     post "/api/v1/incidents", headers: headers, params: JSON.generate(incident_params)

     error = JSON.parse(response.body, symbolize_names:true)
     error_message = "Incident name cannot be blank."

     expect(response).to have_http_status(:not_found)
     expect(error).to have_key(:error)
     expect(error[:error]).to eq("#{error_message}")
    end
    it "Won't create a new incident with missing city" do
      incident_params = ({
        name: "Jim Creeks Fire",
        incident_type: "Fire",
        active: false,
        description: "5th alarm fire",
        location: "Jim's Creek",
        city: "",
        state: "CO",
        start_date: "2020-05-01",
        close_date: "2020-05-10"
         })
     headers = {"CONTENT_TYPE" => "application/json"}

     post "/api/v1/incidents", headers: headers, params: JSON.generate(incident_params)

     error = JSON.parse(response.body, symbolize_names:true)
     error_message = "Incident city cannot be blank."

     expect(response).to have_http_status(:not_found)
     expect(error).to have_key(:error)
     expect(error[:error]).to eq("#{error_message}")
    end
    it "Won't create a new incident with missing state" do
      incident_params = ({
        name: "Jim Creeks Fire",
        incident_type: "Fire",
        active: false,
        description: "5th alarm fire",
        location: "Jim's Creek",
        city: "Denver",
        state: "",
        start_date: "2020-05-01",
        close_date: "2020-05-10"
         })
     headers = {"CONTENT_TYPE" => "application/json"}

     post "/api/v1/incidents", headers: headers, params: JSON.generate(incident_params)

     error = JSON.parse(response.body, symbolize_names:true)
     error_message = "Incident state cannot be blank."

     expect(response).to have_http_status(:not_found)
     expect(error).to have_key(:error)
     expect(error[:error]).to eq("#{error_message}")
    end
    it "Won't create a new incident with missing start_date" do
      incident_params = ({
        name: "Jim Creeks Fire",
        incident_type: "Fire",
        active: false,
        description: "5th alarm fire",
        location: "Jim's Creek",
        city: "Denver",
        state: "CO",
        start_date: "",
        close_date: "2020-05-10"
         })
     headers = {"CONTENT_TYPE" => "application/json"}

     post "/api/v1/incidents", headers: headers, params: JSON.generate(incident_params)

     error = JSON.parse(response.body, symbolize_names:true)
     error_message = "Incident start date cannot be blank."

     expect(response).to have_http_status(:not_found)
     expect(error).to have_key(:error)
     expect(error[:error]).to eq("#{error_message}")
    end
    it "Won't create a new incident with an inactive status and an empty close date" do
      incident_params = ({
        name: "Jim Creeks Fire",
        incident_type: "Fire",
        active: false,
        description: "5th alarm fire",
        location: "Jim's Creek",
        city: "Denver",
        state: "CO",
        start_date: "2020-05-01",
        close_date: ""
         })
     headers = {"CONTENT_TYPE" => "application/json"}

     post "/api/v1/incidents", headers: headers, params: JSON.generate(incident_params)

     error = JSON.parse(response.body, symbolize_names:true)
     error_message = "An inactive incident needs a close date"

     expect(response).to have_http_status(:not_found)
     expect(error).to have_key(:error)
     expect(error[:error]).to eq("#{error_message}")
    end
  end
end
