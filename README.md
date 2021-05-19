# QuickCommand Engine

## About this Project
QuickCommand Engine is the backend web application that connects client side through 13 JSON API endpoints. Each endpoint allows for basic CRUD functionality for the intended user to display both open and closed incidents as well as show what contacts are associated with the incident once an incident has been declared, create a personnel for a given incident, search for both contacts and incidents and more. Receiving current weather and hour by hour forecasts where an incident is currently active ties this functionality into the Weather API Service built with Sinatra.    

## Table of Contents

  - [Getting Started](#getting-started)
    - [Prerequisites](#prerequisites)
    - [Installation](#installation)
  - [Other Repos](#other-repos)
  - [Running the tests](#running-the-tests)
  - [Service Oriented Architecture](#service-oriented-architecture)
  - [DB Schema](#db-schema)
  - [Endpoints](#endpoints)
  - [Built With](#built-with)
  - [Versioning](#versioning)
  - [Authors](#authors)

## Getting Started

To get the web application running, please follow these directions to set up your local machine's testing and development environments. Please follow the section for deployment to see how to deploy this application on Heroku.

  ### Prerequisites
  To run this application you will need Ruby 2.5.3 and Rails 5.2.5

  ### Installation
    1. Clone this repo using the following command:
      `$ git clone git@github.com:Quick-Command/qc-engine.git/`

    2. Run bundle install:
      `$ bundle install`

    3. Setup the database:
      `$ rails db:{create,migrate,seed}`

    4. Add Environment Variables
     - First, add the Figaro gem to the development/test section of the Gemfile and `$ bundle install`: `gem "figaro"`
     - run the command `$ bundle exec figaro install`
     - Add the following environment variables to your `config/application.yml` for access to the WeatherService microservice.

     **IMPORTANT**
     It is imperative that the application.yml file is added to .gitignore so that the personal API keys are not exposed remotely.

## Other Repos

- To explore the full application capabilities, please visit the front end application which hooks into this engine and its endpoints:
  - [Repo](https://github.com/Quick-Command/QuickCommand) | [Heroku](https://quick-command.herokuapp.com/)
- For more information on the WeatherService microservice, please visit the following links
  - [Repo](https://github.com/Quick-Command/weather_service) | [Heroku](https://open-weather-service.herokuapp.com/)

## Service Oriented Architecture

## DB Schema
The following is a depiction of our Database Schema

 ![db_schema](https://user-images.githubusercontent.com/23460878/118385615-12ebbc80-b5d6-11eb-82cd-e54491496c38.png)

## Endpoints
  ### QuickCommand API Contract
​
​
| HTTP verbs | Paths  | Used for | Output |
| ---------- | ------ | -------- | ------:|
| GET | /api/v1/incidents?active=true | Get active incidents | [json](#active-incidents) |
| GET | /api/v1/incidents?active=false | Get resolved incidents | [json](#resolved-incidents) |
| GET | /api/v1/incidents/:incident_id  | Get an incident's details | [json](#incident-details) |
| PUT | /api/v1/incidents/:incident_id  | Update an incident's details | [json](#incident-details) |
| GET | /api/v1/incidents/:incident_id/contacts  | Get an incident's contacts and role in incident | [json](#incident-contacts) |
| GET | /api/v1/incidents/:incident_id/contacts?role=ROLE  | Get a specific contact based on incident and role | [json](#search-incident-contact-by-role) |
| POST | /api/v1/incidents  | Create a new incident | [json](#create-a-incident) |
| POST | /api/v1/contacts  | Create a new contact | [json](#create-a-contact) |
| GET | /api/v1/contacts/:contact_id  | Get a contact's details | [json](#contact-details) |
| PUT | /api/v1/contacts/:contact_id  | Update a contact's details | [json](#update-contact) |
| GET | /api/v1/contacts?name=NAME  | Return contacts that match name query | [json](#search-contacts-name) |
| GET | /api/v1/contacts?role=ROLE  | Return contacts that match role query | [json](#search-contact-role) |

## Types of Incidents (an incident can be one type)
- Fire
- Accident
- Earthquake
- Hazmat Spill
- Power Outage
​
## Types of Roles (a contact can be many roles)
1. Incident Commander
2. PIO
3. Safety Officer
4. Liaison Officer
5. Operations Chief
6. Logistics Chief
7. Finance Chief
8. Planning Chief
​
## JSON Responses
​
## Active Incidents
`GET /api/v1/incidents?active=true`
  ```json
    {
      "data": [
          {
              "id": "27",
              "type": "incident",
              "attributes": {
                  "name": "Jim Creek Fire",
                  "active": true,
                  "incident_type": "Fire",
                  "description": "2 alarm fire caused campfire embers",
                  "location": "Jim Creek Trail",
                  "start_date": "2020-10-10T00:00:00.000Z",
                  "close_date": null
              }
          },
          {
              "id": "28",
              "type": "incident",
              "attributes": {
                  "name": "Avery Substation - Summer black out",
                  "active": true,
                  "incident_type": "Power Outage",
                  "description": "Outage for 12893 homes for 19 hours",
                  "location": "Avery Substation",
                  "start_date": "2020-11-10T00:00:00.000Z",
                  "close_date": null
              }
          },
          {
              "id": "29",
              "type": "incident",
              "attributes": {
                  "name": "5 car accident",
                  "active": true,
                  "incident_type": "Accident",
                  "description": "Details in police report #PR097134834",
                  "location": "2400 BLOCK W COLFAX AVE",
                  "start_date": "2020-12-10T00:00:00.000Z",
                  "close_date": null
              }
          }
      ]
  }
  ```

## Resolved Incidents
`GET /api/v1/incidents?active=false`
  ```json
  "data": [
        {
            "id": "1",
            "type": "incident",
            "attributes": {
                "name": "October 2011 2.0 earthquake",
                "active": false,
                "incident_type": "Earthquake",
                "description": "2.0 earthquake, facade damage to some buildings, 10 trees fell",
                "location": "City Proper",
                "start_date": "2020-01-10T00:00:00.000Z",
                "close_date": "2020-11-05T00:00:00.000Z"
            }
        },
        {
            "id": "2",
            "type": "incident",
            "attributes": {
                "name": "Bear Creek Park Oil Spill",
                "active": false,
                "incident_type": "Hazmat Spill",
                "description": "Exxon manufacturing plant oil spill affected 500 sf",
                "location": "Bear Creek Park",
                "start_date": "2020-02-10T00:00:00.000Z",
                "close_date": "2020-05-20T00:00:00.000Z"
            }
        },
        {
            "id": "3",
            "type": "incident",
            "attributes": {
                "name": "Barker Distribution Substation - tree fall",
                "active": false,
                "incident_type": "Power Outage",
                "description": "Tree feel on power grid, causing outage for 100 homes for 7 hours",
                "location": "Barker Distribution Substation",
                "start_date": "2020-03-10T00:00:00.000Z",
                "close_date": "2020-03-20T00:00:00.000Z"
            }
        },
        {
            "id": "4",
            "type": "incident",
            "attributes": {
                "name": "Del Camino - Rolling Blackout",
                "active": false,
                "incident_type": "Power Outage",
                "description": "Outage for 1000 homes for 10 hours",
                "location": "Del Camino ",
                "start_date": "2020-04-10T00:00:00.000Z",
                "close_date": "2020-05-10T00:00:00.000Z"
            }
        },
        {
            "id": "5",
            "type": "incident",
            "attributes": {
                "name": "Desert Cove Fountain Valley Midway - Rolling blackout",
                "active": false,
                "incident_type": "Power Outage",
                "description": "Outage for 1000 homes for under 1 hour",
                "location": "Desert Cove Fountain Valley Midway",
                "start_date": "2020-05-10T00:00:00.000Z",
                "close_date": "2020-08-08T00:00:00.000Z"
            }
        }
      ]
  ```
​
## Create an Incident
`POST /api/v1/incidents`
* Set header `Content-Type` to `application/json`
* Body for request
  - Active attribute can be left out and it will default to true, or  specify `"active": false` to input a resolved incident, but you must enter a close date for an inactive incident
```json
  {
  "name": "Jim Creeks Fire",
  "incident_type": "Fire",
  "description": "5th alarm fire",
  "location": "Denver, CO",
  "start_date": "2020-05-01",
  "close_date": ""
   }
```
* Return data
```json
  {
    "data": {
        "id": "32",
        "type": "incident",
        "attributes": {
            "name": "Jim Creeks Fire",
            "active": true,
            "incident_type": "Fire",
            "description": "5th alarm fire",
            "location": "Denver, CO",
            "start_date": "2020-05-01T00:00:00.000Z",
            "close_date": null
        }
    }
  }
```
## Incident Details
`GET /api/v1/incidents/:incident_id`
  ```json
  {
    "data": {
      "id": "1",
      "type": "incident",
      "id": "1",
        "type": "incident",
        "attributes": {
          "name": "Jim Creek Fire",
          "type": "Fire",
          "status": "resolved",
          "description": "Large fire at Jim's",
          "location": "Jim's Creek park",
          "start_date": "2021-01-01",
          "close_date": "2021-05-13"
        }
    }
  }
  ```
​
## Incident Contacts
`GET /api/v1/incidents/:incident_id/contacts`
  ```json
  {
    "data": [
      {
        "id": "1",
          "type": "contact",
          "attributes": {
            "name": "Moo Philips",
            "title": "Incident Commander",
            "email": "mphillips@email.gov",
            "phone": "123-456-7890"
          }
      },
      {
        "id": "20",
          "type": "contact",
          "attributes": {
            "name": "Quack Doc",
            "title": "Safety Officer",
            "email": "qdoc@email.gov",
            "phone": "198-765-4321"
          }
      }
    ]
  }
  ```
## Built With
- Ruby
- Rails
- RSpec
- FactoryBot
- Faker

## Versioning
- Ruby 2.5.3
- Rails 5.2.6

## Authors
- **Alexa Morales Smyth**
| [GitHub](https://github.com/amsmyth1) |
  [LinkedIn](https://www.linkedin.com/in/moralesalexa/)
- **Cameron Mackintosh**
| [GitHub](https://github.com/cbmackintosh) |
  [LinkedIn](https://www.linkedin.com/in/cameron-mackintosh-1341b173/)
- **Chuck Morris**
| [GitHub](https://github.com/percworld) |
  [LinkedIn](https://www.linkedin.com/in/chuck-morris-56819918/)
- **Jeff Shepherd**
|  [GitHub](https://github.com/JeffShepherd) |
  [LinkedIn](https://www.linkedin.com/in/jefflshepherd/)
- **Jeremiah Michlitsch**
|  [GitHub](https://github.com/jmichlitsch) |
  [LinkedIn](https://www.linkedin.com/in/jeremiah-michlitsch-49048a206/)
- **Katy La Tour**
| [GitHub](https://github.com/klatour324) |
  [LinkedIn](https://www.linkedin.com/in/klatour324/)
