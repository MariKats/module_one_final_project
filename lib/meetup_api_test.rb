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
       puts "Event Number: #{index+1}"
       puts "Event Name: #{event["name"]}"
      # #  raises error if empty
      #   if event["venue"]["address_1"] != " "
      #    puts "Event Location: #{event["venue"]["address_1"]}"
      #  else
      #    puts "Event Location: unknown"
       end
       puts "Event Host: #{event["group"]["name"]}"
       puts "****************************************************"
     end
     events
   end
 end
