require 'rest-client'
require 'json'
require 'pry'

class Meetup

  attr_reader :query

  BASE_URL = "https://api.meetup.com/find/events?key=6e14c1682053412f223a299741118&sign=true"

  def initialize(query:)
    @query = query
  end

  def response_data
    # response = RestClient.get("#{BASE_URL}&radius=25.0&zip=10019")
    response = RestClient.get("https://api.meetup.com/open_events?key=6e14c1682053412f223a299741118&sign=true&radius=10.0&zip=10019&photo-host=public")
    meetup_data = JSON.parse(response)
    binding.pry
  end

  def meetups
    response_data["results"]
  end

  def create_events
    meetups.each do |meetup|
      create_event(meetup)
    end
  end

  private

  def create_event(meetup)

  end
end
