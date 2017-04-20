require 'net/http'
 require 'open-uri'
 require 'json'
 require 'pry'

 class GetEvents

   BASE_URL = "https://api.meetup.com/2/open_events?"

   def get_events_by_zipcode_category_and_time(zip, cat_name, start, end_t)
     url = "#{BASE_URL}zip=#{zip}&category=#{cat_name}&time=#{start},#{end_t}&status=upcoming&key=6e14c1682053412f223a299741118"
     uri = URI.parse(url)
     response = Net::HTTP.get_response(uri)
     events = JSON.parse(response.body)
     events["results"].each_with_index do |event, index|
       puts "Event Number: #{index+1}".colorize(:blue)
       puts "Event Name: #{event["name"]}".colorize(:blue)
       puts "Event Host: #{event["group"]["name"]}".colorize(:blue)
       time = epoch_to_date(event["time"])
       puts "Event Date: #{time}".colorize(:blue)
       puts "Event Link: #{event["event_url"]}".colorize(:blue)
       puts "*****************************************************".colorize(:green)
     end
     events
   end
 end
