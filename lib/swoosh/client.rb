
module Swoosh
  class Client
    
    def initialize(token)
      @api = Api.new(token)
    end
    
    def todays_fuel
      total_fuel = 0
      @api.today.each do |entry|
        fuel = entry['metricSummary']['fuel']
        total_fuel += fuel
      end
      total_fuel
    end
    
    def lifetime_fuel
      fuel = 0
      @api.aggregate['summaries'].each do |entry|
        if entry['experienceType'] == 'ALL'
          entry['records'].each do |record|
            if record['recordType'] == 'LIFETIMEFUEL'
              return record['recordValue'].to_i
            end
          end
        end
      end
      fuel
    end
    
  end
end