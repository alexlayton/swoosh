require 'rubygems'
require 'httparty'

module Swoosh
  class Api
    include HTTParty
    
    base_uri 'https://api.nike.com/me'
    format :json
  
    def initialize(token)
      @token = token
    end
  
    def activities
      self.class.get("/sport/activities", options).parsed_response['data']
    end
    
    def aggregate
      self.class.get("/sport", options).parsed_response
    end
    
    def today
      finish = Time.now
      start = finish - (60 * 60 * 24)
      newOptions = options
      newOptions[:query]['startDate'] = start.strftime('%Y-%m-%d')
      newOptions[:query]['endDate'] = finish.strftime('%Y-%m-%d')
      self.class.get("/sport/activities", newOptions).parsed_response['data']
    end
    
    def activity(id)
      self.class.get("/sport/activity/#{id}", options).parsed_response['data']
    end

    private
    
    def options
      options = {
        :query => {
          'access_token' => @token
        },
        :headers => {
          'appid' => 'fuelband',
          'Accept' => 'application/json',
          'Content-Type' => 'application/json'
        }
      }
    end
  
  end
end